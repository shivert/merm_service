client = Elasticsearch::Client.new({
                              log: true
                          })

client.indices.put_settings body: { 'index.blocks.read_only_allow_delete' => "null"}

Elasticsearch::Model.client = client