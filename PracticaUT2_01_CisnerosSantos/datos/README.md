s# 5 Copia de Seguridad,Seguridad y Límites

### 5.1.Procedimiento de Copia y Restauración

El procedimiento utiliza las herramientas nativas del MongoDB Database Tools (mongodump y mongorestore) para copias lógicas consistentes, además de describir la alternativa gestionada en MongoDB Atlas.

```bash
mongodump --uri="mongodb+srv://<username>:<password>@<cluster-url>/test?retryWrites=true&w=majority" --gzip
```

```bash
mongorestore --uri="mongodb+srv://<username>:<password>@<cluster-url>/test?retryWrites=true&w=majority" --gzip --drop
```

### 5.2. Usuarios y Roles

- Cliente: Tiene permisos de lectura y escritura unicamente sobre la base de datos, si la web sufre un ataquue no podria acceder a otras funciones desde este rol.
- Administrador:Protegidos con seguridad de autenticación y limitados por una lista de ip.

### 5.3. Datos a Cifrar,Anonimizar y Excluir

- Anonimizar: Ofuscar los datos de los usuarios para que no muestren los datos reales de lso usuarios.
