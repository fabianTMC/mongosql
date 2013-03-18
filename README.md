# MongoSQL

I love mongo like query! <3
So this module converts mongo query to SQL (where phrase)

# Install 

```
$ git clone git://github.com/muddydixon/mongosql.git
```

# Usage

```javascript
var MongoSQL = require('mongosql');
var mongosql = new MongoSQL();
mongosql.parse({gender: 1}); 
// {where: "gender = ?", value: [1]}
mongosql.parse({gender: 1, age: [23, 24, 25]}); 
// {where: "gender = ? AND age IN (?, ?, ?)", value: [1, 23, 24, 25]}

# TODO

* fields with group by

# Author

Muddy Dixon muddydixon@gmail.com

# License

Copyright 2013- Muddy Dixon (muddydixon)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
