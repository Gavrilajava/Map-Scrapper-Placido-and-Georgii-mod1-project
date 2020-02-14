class Place < ActiveRecord::Base
    has_many :place_tag_joiners
    has_many :tags, through: :place_tag_joiners
    has_many :pages
    has_many :matches, through: :pages
    has_many :keywords, through: :matches
    
    def tag_relevance
        self.tags.reduce(0.0) {|memo, tag| tag.relevance ? memo + tag.relevance : memo}
    end

    def keyword_relevance
        self.matches.reduce(0.0) {|memo, match| match.keyword ? memo + (match.keyword.relevance * match.count) : memo}
    end

    def distance_relevance_multiplier
        search_radius = Search.first.radius
        1.0 - ((self.distance) ** 2 / (2.0 * (search_radius ** 2)))
    end

    def relevance
        base_relevance = 100.0

        highest_tag_relevance = Place.all.max_by {|place| place.tag_relevance}.tag_relevance
        tag_multiplier_numerator_base = highest_tag_relevance != 0 ? tag_relevance / highest_tag_relevance : 0.0
        tag_multiplier = (tag_multiplier_numerator_base + 1.0) / 1.0

        highest_keyword_relevance = Place.all.max_by {|place| place.keyword_relevance}.keyword_relevance
        keyword_multiplier_numerator_base = highest_keyword_relevance != 0 ? keyword_relevance / highest_keyword_relevance : 0.0
        keyword_multiplier = (keyword_multiplier_numerator_base + 1.0) / 1.0
        
        normalized_relevance = base_relevance * tag_multiplier * keyword_multiplier * distance_relevance_multiplier / 2
        normalized_relevance.to_i
    end

    def is_internal_link?(link)
        exceptions = ["www.facebook.com", "www.google.com"]
        link_host = URI.parse(link).host
        link_host.prepend("www.") unless link_host.starts_with?("www.")
        website_host = URI.parse(self.website).host
        website_host.prepend("www.") unless website_host.starts_with?("www.")
        website_host == link_host && !exceptions.include?(link_host)
    end

    def self.get_10_most_tag_relevant
        Place.all.sort_by { |place| place.tag_relevance}.first(10)
    end

    def self.get_10_most_relevant
        spinner = TTY::Spinner.new("[:spinner] Choosing ...", format: :star)
        spinner.auto_spin

        Place.all.sort_by { |place| place.relevance}.reverse!.first(10)
    end

    def tag_titles #returns all tag names associated with place
        self.tags.map {|tag| tag.title}
    end
end