resource "aws_dynamodb_table" "codingtips-dynamodb-table" {
  name = "CodingTips"
  read_capacity = 5
  write_capacity = 5
  range_key = "Date"
  hash_key = "Author"

  attribute {
      name = "Author"
      type = "S"
    }
  attribute {
      name = "Date"
      type = "N"
    }
}
