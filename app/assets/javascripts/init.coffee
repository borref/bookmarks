# API Setup
BASE_URL = 'http://localhost:3000/api'

@api = new RestClient(BASE_URL)

# Define API resources
@api.res 'bookmarks'
