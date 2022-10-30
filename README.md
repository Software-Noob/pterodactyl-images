# Pterodactyl/WISP Docker Images

Docker images that can be used with the Pterodactyl/WISP Game Panel. You can request more images by opening a new issue. These are mostly created for myself.

Additional Pterodactyl images can be found at [Parkervcp](https://github.com/parkervcp/images), [Matthewpi](https://github.com/matthewpi/images) and [Yolks](https://github.com/pterodactyl/yolks) repositories.

## How to add image to your egg

Navigate to `Admin Panel -> Nests -> Select your egg`. Add Docker image URL(s) from the [available list](https://github.com/Software-Noob/pterodactyl-images#pterodactylwisp-images) into the Docker Images section.

![image](https://user-images.githubusercontent.com/10975908/120903180-56719d80-c64d-11eb-8666-02de8ea80701.png)

### Supported Platforms

| Image                | Supported platforms |
| -------------------- | ------------------- |
| Java Azul Zulu       | AMD64, ARM64        |
| Java Eclipse Temurin | AMD64, ARM64        |
| Java GraalVM         | AMD64, ARM64        |
| Java Shenandoah      | AMD64, ARM64        |
| Java OpenJ9          | AMD64               |
| Node.js              | AMD64, ARM64        |
| Python               | AMD64, ARM64        |
| Sourcemod            | AMD64               |

#### Java Azul Zulu [AMD64/ARM64]

- [Java 8 Zulu](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-zulu/8)
  - `ghcr.io/software-noob/pterodactyl-images:java_8_zulu`
- [Java 11 Zulu](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-zulu/11)
  - `ghcr.io/software-noob/pterodactyl-images:java_11_zulu`
- [Java 16 Zulu](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-zulu/16)
  - `ghcr.io/software-noob/pterodactyl-images:java_16_zulu`
- [Java 17 Zulu](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-zulu/17)
  - `ghcr.io/software-noob/pterodactyl-images:java_17_zulu`
- [Java 18 Zulu](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-zulu/18)
  - `ghcr.io/software-noob/pterodactyl-images:java_18_zulu`
- [Java 19 Zulu](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-zulu/19)
  - `ghcr.io/software-noob/pterodactyl-images:java_19_zulu`

### Java Eclipse Temurin [AMD64/ARM64]

- [Java 8](https://github.com/Software-Noob/pterodactyl-images/tree/main/java/8)
  - `ghcr.io/software-noob/pterodactyl-images:java_8`
- [Java 11](https://github.com/Software-Noob/pterodactyl-images/tree/main/java/11)
  - `ghcr.io/software-noob/pterodactyl-images:java_11`
- [Java 16](https://github.com/Software-Noob/pterodactyl-images/tree/main/java/16)
  - `ghcr.io/software-noob/pterodactyl-images:java_16`
- [Java 17](https://github.com/Software-Noob/pterodactyl-images/tree/main/java/17)
  - `ghcr.io/software-noob/pterodactyl-images:java_17`
- [Java 18](https://github.com/Software-Noob/pterodactyl-images/tree/main/java/18)
  - `ghcr.io/software-noob/pterodactyl-images:java_18`
- [Java 19](https://github.com/Software-Noob/pterodactyl-images/tree/main/java/19)
  - `ghcr.io/software-noob/pterodactyl-images:java_19`

### Java GraalVM [AMD64/ARM64]

- [Java 8 GraalVM-CE](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-graalvm/8)
  - `ghcr.io/software-noob/pterodactyl-images:java_8_graalvm`
- [Java 11 GraalVM JDK](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-graalvm/11)
  - `ghcr.io/software-noob/pterodactyl-images:java_11_graalvm`
- [Java 17 GraalVM JDK](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-graalvm/17)
  - `ghcr.io/software-noob/pterodactyl-images:java_17_graalvm`

#### Java OpenJ9 [AMD64]

- [Java 8 OpenJ9](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-openj9/8)
  - `ghcr.io/software-noob/pterodactyl-images:java_8_openj9`
- [Java 11 OpenJ9](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-openj9/11)
  - `ghcr.io/software-noob/pterodactyl-images:java_11_openj9`
- [Java 16 OpenJ9](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-openj9/16)
  - `ghcr.io/software-noob/pterodactyl-images:java_16_openj9`
- [Java 17 OpenJ9](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-openj9/17)
  - `ghcr.io/software-noob/pterodactyl-images:java_17_openj9`
- [Java 18 OpenJ9](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-openj9/18)
  - `ghcr.io/software-noob/pterodactyl-images:java_18_openj9`

#### Java Shenandoah [AMD64/ARM64]

- [Java 8 Shenandoah](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-shenandoah/8)
  - `ghcr.io/software-noob/pterodactyl-images:java_8_shenandoah`
- [Java 11 Shenandoah](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-shenandoah/11)
  - `ghcr.io/software-noob/pterodactyl-images:java_11_shenandoah`
- [Java 17 Shenandoah](https://github.com/Software-Noob/pterodactyl-images/tree/main/java-shenandoah/17)
  - `ghcr.io/software-noob/pterodactyl-images:java_17_shenandoah`

#### Node.js [AMD64/ARM64]

- [Nodejs 12](https://github.com/Software-Noob/pterodactyl-images/tree/main/nodejs/12)
  - `ghcr.io/software-noob/pterodactyl-images:nodejs_12`
- [Nodejs 14](https://github.com/Software-Noob/pterodactyl-images/tree/main/nodejs/14)
  - `ghcr.io/software-noob/pterodactyl-images:nodejs_14`
- [Nodejs 15](https://github.com/Software-Noob/pterodactyl-images/tree/main/nodejs/15)
  - `ghcr.io/software-noob/pterodactyl-images:nodejs_15`
- [Nodejs 16](https://github.com/Software-Noob/pterodactyl-images/tree/main/nodejs/16)
  - `ghcr.io/software-noob/pterodactyl-images:nodejs_16`
- [Nodejs 17](https://github.com/Software-Noob/pterodactyl-images/tree/main/nodejs/17)
  - `ghcr.io/software-noob/pterodactyl-images:nodejs_17`
- [Nodejs 18](https://github.com/Software-Noob/pterodactyl-images/tree/main/nodejs/18)
  - `ghcr.io/software-noob/pterodactyl-images:nodejs_18`
- [Nodejs 19](https://github.com/Software-Noob/pterodactyl-images/tree/main/nodejs/19)
  - `ghcr.io/software-noob/pterodactyl-images:nodejs_19`

#### Python [AMD64/ARM64]

- [Python 2.7](https://github.com/Software-Noob/pterodactyl-images/tree/main/python/2.7)
  - `ghcr.io/software-noob/pterodactyl-images:python_2.7`
- [Python 3.6](https://github.com/Software-Noob/pterodactyl-images/tree/main/python/3.6)
  - `ghcr.io/software-noob/pterodactyl-images:python_3.6`
- [Python 3.7](https://github.com/Software-Noob/pterodactyl-images/tree/main/python/3.7)
  - `ghcr.io/software-noob/pterodactyl-images:python_3.7`
- [Python 3.8](https://github.com/Software-Noob/pterodactyl-images/tree/main/python/3.8)
  - `ghcr.io/software-noob/pterodactyl-images:python_3.8`
- [Python 3.9](https://github.com/Software-Noob/pterodactyl-images/tree/main/python/3.9)
  - `ghcr.io/software-noob/pterodactyl-images:python_3.9`
- [Python 3.10](https://github.com/Software-Noob/pterodactyl-images/tree/main/python/3.10)
  - `ghcr.io/software-noob/pterodactyl-images:python_3.10`
- [Python 3.11](https://github.com/Software-Noob/pterodactyl-images/tree/main/python/3.11)
  - `ghcr.io/software-noob/pterodactyl-images:python_3.11`

### Game specific

#### Sourcemod [ARM64]

- [Source with sourcemod](https://github.com/Software-Noob/pterodactyl-images/tree/main/games/source-sourcemod)
  - `ghcr.io/software-noob/pterodactyl-images:games_source-sourcemod`

  Optionally installs and updates SourceMod/Metamod on each server startup. Requires adding egg environment variable `SOURCEMOD`.

  ![image](https://user-images.githubusercontent.com/10975908/159126935-2e3f2883-3b89-4395-b28d-ab23dad0e5f8.png)

  Custom versions can be set with the use of `SM_VERSION` and `MM_VERSION` variables. Invalid versions will default to the latest stable version. Default path is set to csgo and can be overridden with `INSTALL_PATH` egg environment variable.
