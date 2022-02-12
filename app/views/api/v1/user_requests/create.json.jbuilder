json.request do
  json.partial! "api/v1/join_requests/request", request: @request
end
