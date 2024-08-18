# Preparacion para el workshop

* Background de epigenetica useful
* Experiencia con Linux y el terminal
* Instalar Software (Docker y IGV)
* Download todo el code que se usa en este workshop o usa USB stick
* Usa USB stick para tomar references y otra data usada en el workshop

# Download el repositorio para el workshop

https://github.com/dborgesr/Epigenetics_Workshop

Usando el cli 
```
git clone https://github.com/dborgesr/Epigenetics_Workshop.git
```

# Instalar Docker

Docker es un programa que te deja crear y usar "Imagenes". Una imagen es como una machina virtual, con su proprio sistema operativo

[Install Docker](https://docs.docker.com/engine/install/)


# Instalar IGV
IGV es un genome viewer, nos deja ver un genoma que tenemos (Rice y Honeysuckle) con "tracks", que incluye todo tipos de "seq" data, incluyendo RNA-seq, DNA-seq, ATAC-seq, etc
[IGV](https://igv.org/doc/desktop/#DownloadPage/)

# Instalar VSCode
Editar y leer code:
[VSCode](https://code.visualstudio.com/) Es muy bueno, simple y poderoso para una terminal y editar code


## Abrir terminal

### Usando WSL2 con Windows
[Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
[WSL2 Docker](https://docs.docker.com/desktop/wsl/)

### Usando terminal en MACOS
Built-in Xterminal

# Obtener imagen EpiStudent
En vez de download image vamos a usar una que tengo en un file

En tu terminal en el lugar de tu repositorio
```bash
cd Epigenetics_Workshop
docker load epistudent.tar
```


# Optional construir imagen

Tambien es posible construir la imagen de Docker usando 

```bash
docker-compose build epistudent
```

# Cambiar el .env file

Cambiar el .env file con el path que coresponde a el lugar del repositorio en el disco duro

```
# External host variables -- EDIT HERE --
repo_dir=/mnt/d/Epigenetics_Workshop
data_dir=/mnt/d/Epigenetics_Workshop/input_data
```


# Empezar la imagen

```
docker compose up -d epistudent
```


# Empezar workshop

Ir a website en tu browser en port 8900 [localhost:8902](http://localhost:8902)
