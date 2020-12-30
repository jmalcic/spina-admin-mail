Mobility.configure do
  plugins do
    backend :table
    reader
    writer
    backend_reader
    active_record
    query
    cache
    fallbacks
    presence
    default
    dirty
  end
end
