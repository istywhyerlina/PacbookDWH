select * 
from {{ source("dwh", "book_author") }}