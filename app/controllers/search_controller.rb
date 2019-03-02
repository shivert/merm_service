class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    response = Merm.__elasticsearch__.search(
        query: {
            constant_score: {
                filter: {
                    term: {
                        owner_id: current_user.id
                    }
                }
            }
        },
        size:  1000
    ).results


    render json: {
        results: response.results,
        total: response.total
    }
  end

  def execute
    response = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: {
                    multi_match: {
                        query: params['q'],
                        fields: ["name", "description"],
                        fuzziness: "AUTO"
                    }
                },
                filter: {
                  term: {
                      owner_id: current_user.id
                  }
                }
            }
        },
        size:  1000
    ).results


    render json: {
        results: response.results,
        total: response.total
    }
  end
end
