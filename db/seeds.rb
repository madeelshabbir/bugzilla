# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
              { name: 'dev1', email: 'dev1@devsinc.com', password: 'G@mes321', user_type: 0 },
              { name: 'dev2', email: 'dev2@devsinc.com', password: 'G@mes321', user_type: 0 },
              { name: 'manager1', email: 'manager1@devsinc.com', password: 'G@mes321', user_type: 1 },
              { name: 'manager2', email: 'manager2@devsinc.com', password: 'G@mes321', user_type: 1 },
              { name: 'qa1', email: 'qa1@devsinc.com', password: 'G@mes321', user_type: 2 },
              { name: 'qa2', email: 'qa2@devsinc.com', password: 'G@mes321', user_type: 2 }
            ])
