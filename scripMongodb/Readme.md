# Comandos MongoDB

##  Usar una base de datos
```
show dbs
use db1
```
## Crear una collections
```
db.createCollection("ejemplo")
```

## Mostrar las colecciones en la base de datos actual
```
show collections
```


## Insertar un documento en la colección "empleado"
```
db.empleado.insertOne({
    nombre: "Ramon",
    edad: 23
})
```

## Buscar documentos en la colección "empleado"
```
db.empleado.find()
```

## Buscar todos los documentos en la colección "empleado"
```
db.empleado.find({})
```
## Eliminar la base de datos actual
```
db.dropDatabase()
```

## Insertar varios documentos en la colección "empleado"
```
db.empleado.insertMany([
    {nombre: "Meregirldo", edad: 67},
    {nombre: "asx", edad: 212},
    {nombre: "marlo", edad: 23}
])
```


## Insertar un documento en la colección "ejemplo
```
db.ejemplo.insertOne({"nombre": "Casemiro", "edad": 23})
```

# Consultas básicas
## Consultar documentos por valor de campo
```
db.libros.find({editorial:{$eq:"Biblio"}})
db.libros.find({precio:25})
db.libros.find({precio:{$eq:25}})
```
## Consultar documentos utilizando operadores de comparación
```
db.libros.find({precio:{$gte:20}})
db.libros.find({precio:{$lt:5}})
db.libros.find({editorial:{$in:['Bilio', 'Planeta']}})
db.libros.findOne({precio:{$in:[20, 25]}})
db.libros.find({precio:{$gt:25},cantidad:{$lt:15}})
db.libros.find({$and: [{precio:{$gt:25}}, {cantidad:{$lt:15}}]})
```

## Consultas con operador OR
```
db.libros.find({$or:[{precio:{$gt:25}}, {cantidad:{$lt:15}}]})
db.libros.find({$or:[{editorial:'Biblio', precio:{$gt:40}}, {editorial:'Planeta', precio:{$gt:30}}]})
```
## Consultas por igualdad y existencia de campos
```
db.libros.find({}, {titulo:1})
db.libros.find({titulo:'Don quijote'}, {titulo:1})
db.libros.find({titulo:'Don quijote'}, {_id:0, titulo:1})
db.libros.find({titulo:{$exists:true}})
db.libros.find({$and:[{precio:{$gt:5}}, {autor:{$exists:true}}]})
```
# Actualizaciones
## Actualizar un documento

```
db.libros.updateOne({titulo:'JSON para todos'}, {$set:{titulo:'Java el rey'}})
db.libros.updateMany({precio:{$gt:9}}, {$set:{precio:150}})
db.libros.updateMany({cantidad:{$gt:20}}, {$mul:{precio:2}})
db.libros.replaceOne({"_id":13}, {"_id":14, "titulo":"Las pato aventuras de Ezequiel Alias Mateo"})
```
# Eliminaciones
## Eliminar documentos
**Eliminar el primer documento que cumpla la condición**
```
db.libros.deleteOne({"_id":13})
```
**Eliminar todos los documentos que cumplan la condición**
```
db.libros.deleteOne({"titulo":"Java el rey"})
db.libros.deleteMany({"cantidad":{$gt:20}}) 
```
# Eliminar colecciones
```
db.ejemplo.drop()
```
# Eliminar unada base de datos
```
db.dropDatabase

```

# Expresiones regulares
## Consultas utilizando expresiones regulares
**Buscar documentos que contengan la letra "t"**
```
db.libros.find({"titulo":/t/}) 
```
**Buscar documentos que contengan la palabra "Java"**
```
db.libros.find({"titulo":/Java/}) 
```
**Buscar documentos cuyo título termine con "tos"**
```
db.libros.find({"titulo":/tos$/}) 
```
**Buscar documentos cuyo título empiece con "J"**
```
db.libros.find({"titulo":/^J/})
```

**Buscar documentos que contengan la palabra "para"**
```
db.libros.find({"titulo":{$regex:"para"}}) 
```
**Búsqueda insensible a mayúsculas y minúsculas**
```
db.libros.find({"titulo":{$regex:"JAVA" , $options:'i'}}) 
```
# Consultas avanzadas
## Ordenar documentos

**Ordenar documentos por título y editorial**
``` 
db.libros.find({}, {titulo:1, precio:1}).sort({titulo:1, editorial:1})
```
**Ordenar documentos por título de forma ascendente**
```
db.libros.find({}, {titulo:1, precio:1}).sort({titulo:1}) 
```
**Ordenar documentos por título de forma descendente**
``` 
db.libros.find({}, {titulo:1, precio:1}).sort({titulo:-1}) 
 
```
## Omitir y limitar documentos
```
db.libros.find({}, {titulo:1, precio:1}).skip(2) 
db.libros.find({}, {titulo:1, precio:1}).limit(2) 
```
## Contar documentos
**Count**
```
db.libros.find({}, {titulo:1, precio:1}).count()
```
## Skip es un saltar alginos documentos
```
db.libros.find({},{"titulo":1,"precio":1,_id:0, "editorial":1}).skip(2)
```
## limit da los que estan hatn en la parte superior
```
db.libros.find({},{"titulo":1,"precio":1,_id:0, "editorial":1}).limit(2)
```
## size nuestra el numero dse los documentos que cumplasn la condicion
```
db2> db.libros.find({},{"titulo":1,"precio":1,_id:0, "editorial":1}).size()

```


# Agregations 
```
db.libros.aggregate( [ { $match: {editorial:'Biblio'}}, { $project:{id_:0, titulo:1, precio:1,'Nombre Editorial': '$editorial' }}])

```
## pipeline1
```
[
    {
      $match:
        /**
         * query: The query in MQL.
         */
        {
          editorial: "Biblio",
        },
    },
    {
      $project:
        /**
         * specifications: The fields to
         *   include or exclude.
         */
        {
          _id: 0,
          titulo: 1,
          precio: 1,
          cantidad: 1,
          "Nombre Editorial": "#editorial",
          "Total Ganancia": {
            $multiply: ["$precio", "$cantidad"],
          },
        },
    },
    {
      $sort:
        /**
         * Provide any number of field/order pairs.
         */
        {
          precio: 1,
        },
    },
  ]
```
## pipeline2 group
```
[
    {
      $group:
        /**
         * _id: The id of the group.
         * fieldN: The first field name.
         */
        {
          _id: "$editorial",
          "Numero documentos": {
            $count: {},
          },
        },
    },
    {
      $sort:
        /**
         * Provide any number of field/order pairs.
         */
        {
          "Numero documentos": 1,
        },
    },
  ]
```
## pipeline 3 actualizado
 ```
  [
    {
      $group:
        /**
         * _id: The id of the group.
         * fieldN: The first field name.
         */
        {
          _id: "$editorial",
          "Numero de docuemtos ": {
            $count: {},
          },
          "media:": {
            $avg: "$precio",
          },
          "Precio Max:": {
            $max: "$precio",
          },
        },
    },
    {
      $sort:
        /**
         * Provide any number of field/order pairs.
         */
        {
          "Precio Max:": 1,
        },
    },
  ]
  ```

## pipeline 4
  ```
  [
    {
      $group:
        /**
         * _id: The id of the group.
         * fieldN: The first field name.
         */
        {
          _id: "$editorial",
          Numero: {
            $count: {},
          },
          media: {
            $avg: "precio",
          },
        },
    },
    {
      $set:
        /**
         * field: The field name
         * expression: The expression.
         */
        {
          "Media Total": {
            $trunc: ["$media", 2],
          },
        },
    },
    {
      $out:
        /**
         * Provide the name of the output collection.
         */
        "Media_Editoriales",
    },
  ]
  // 
  [
    {
      $group:
        /**
         * _id: The id of the group.
         * fieldN: The first field name.
         */
        {
          _id: "$editorial",
          Numero: {
            $count: {},
          },
          media: {
            $avg: "precio",
          },
        },
    },
    {
      $set:
        /**
         * field: The field name
         * expression: The expression.
         */
        {
          "Media Total": {
            $trunc: ["$media", 2],
          },
        },
    },
    {
      $unset:
        /**
         * Provide the name of the output collection.
         */
        "media",
    },
  ]
```