resource "aws_keyspaces_table" "cat_table" {
  keyspace_name = aws_keyspaces_keyspace.cat_keyspace.name
  table_name    = "cat_table"

  schema_definition {
    column {
      name = "id"
      type = "uuid"
    }
    column {
      name = "nome"
      type = "text"
    }
    column {
      name = "idade"
      type = "int"
    }
    column {
      name = "raca"
      type = "text"
    }
    partition_key {
      name = "id"
    }
  }

}