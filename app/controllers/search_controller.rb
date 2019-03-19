class SearchController < ApplicationController
  before_action :authenticate_user!

  ## Full List of Merms used for AutoComplete
  def merms
    response = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        _source: ["id", "name"],
        sort: { last_accessed: {order: "desc"}},
        size:  1000
    ).results

    render json: {
        results: response.results,
        total: response.total
    }
  end

  def dashboard
    custom = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        sort: { last_accessed: {order: "desc"}},
        size:  1000
    ).results

    shared = Share.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {shared_with_id: current_user.id}
                    },
                    {
                        term: {read: false}
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        sort: { created_at: {order: "desc"}},
        size:  1000
    ).results

    recent = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        range: {
                            last_accessed: {
                                gte: "now-1d",
                                lt:  "now"
                            }
                        }
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        sort: { last_accessed: {order: "desc"}},
        size:  10
    ).results

    favorites = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        term: {favorite: true}
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        sort: { last_accessed: {order: "desc"}},
        size:  10
    ).results

    render json: {
        custom: custom.results,
        shared: shared.results,
        recent: recent.results,
        favorites: favorites.results
    }
  end

  def categories
    response = Category.__elasticsearch__.search(
        _source: ["id", "rank", "name", "custom"],
        query: {
            term: {
                owner_id: current_user.id
            },
        },
        sort: { rank: {order: "asc"}},
        size:  1000
    ).results

    render json: {
        results: response.results,
        total: response.total
    }
  end

  def search
    if params['categoryId'].present?
      response = Merm.__elasticsearch__.search(
          query: {
              bool: {
                  must: [
                      {
                          term: {owner_id: current_user.id}
                      },
                      {
                          term: {category_id: params['categoryId']}
                      },
                      {
                          term: {expired: false}
                      }
                  ]
              }
          },
          sort: { last_accessed: {order: "desc"}},
          size:  1000
      ).results
    else
      response = Merm.__elasticsearch__.search(
          query: {
              bool: {
                  must: {
                      multi_match: {
                          query: params['q'],
                          fields: ["name", "description","tags.name"],
                          fuzziness: "AUTO"
                      }
                  },
                  filter: {
                      bool: {
                          should: {
                              term: {
                                  owner_id: current_user.id
                              }
                          },
                          must: {
                              term: {
                                  expired: false
                              }
                          }
                      }
                  }
              }
          },
          sort: { last_accessed: {order: "desc"}},
          size:  1000
      ).results
    end


    render json: {
        results: response.results,
        total: response.total
    }
  end

  def advanced

    filter = [{ term: {owner_id: current_user.id} },
              {term: {expired: false} }]

    filter.append({
                      term: {"source": params["source"].downcase}
                  }) if params["source"].present?

    filter.append({
                      term: {"category_id": params["categoryId"]}
                  }) if params["categoryId"].present?

    filter.append({
                      term: {"owner_id": params["ownerId"]}
                  }) if params["ownerId"].present?

    filter.append({
                      range: {
                          last_accessed: {
                              gte: JSON.parse(params["accessDates"])["startDate"],
                              lt:  JSON.parse(params["accessDates"])["endDate"]
                          }
                      }
                  }) if (params["accessDates"].present? )

    filter.append({
                      terms: {"tags.name": params["tags"].map { |n| n.downcase }}
                  }) if params["tags"].present?

    response = Merm.__elasticsearch__.search(
        query: {
            bool: {
                filter: filter
            }
        },
        size:  1000
    ).results


    render json: {
        results: response.results,
        total: response.total
    }
  end

  def favorite
    response = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        term: {"favorite": true}
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        sort: { last_accessed: {order: "desc"}},
        size:  1000
    ).results


    render json: {
        results: response.results,
        total: response.total
    }
  end

  def recent
    response = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        range: {
                            last_accessed: {
                                gte: "now-1d",
                                lt:  "now"
                            }
                        }
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        sort: { last_accessed: {order: "desc"}},
        size:  1000
    ).results

    render json: {
        results: response.results,
        total: response.total
    }
  end

  def expired
    response = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        term: {expired: true}
                    }
                ]
            }
        },
        sort: { last_accessed: {order: "desc"}},
        size:  1000
    ).results


    render json: {
        results: response.results,
        total: response.total
    }
  end

  def category
    response = Merm.__elasticsearch__.search(
        query: {
            bool: {
                must: [
                    {
                        term: {owner_id: current_user.id}
                    },
                    {
                        term: {"category.name": params["q"].downcase}
                    },
                    {
                        term: {expired: false}
                    }
                ]
            }
        },
        sort: { last_accessed: {order: "desc"}},
        size:  1000
    ).results


    render json: {
        results: response.results,
        total: response.total
    }
  end

  def shared
    response = Share.__elasticsearch__.search(
        query: {
            term: {
                shared_with_id: current_user.id
            }
        },
        sort: { created_at: {order: "desc"}},
        size:  1000
    ).results

    render json: {
        results: response.results,
        total: response.total
    }
  end
end
