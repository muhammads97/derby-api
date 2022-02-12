json.requests do
  json.array! @requests, partial: "api/v1/join_requests/minimal", as: :request
end