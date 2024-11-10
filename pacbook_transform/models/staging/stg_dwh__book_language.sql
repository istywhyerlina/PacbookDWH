select * 
from {{ source("dwh", "book_language") }}