Documentacion:

Con base en el código, así funciona la app en dos flujos principales:

Flujo 1 — Cargar los salones de Pokémon

1. El usuario abre la pantalla de salones (o cambia la generación desde el dropdown).
2. El PokemonRoomsController reacciona a ese cambio y le pide al CreatePokemonRoomsUseCase que arme los salones para esa generación.
3. Ese caso de uso, a su vez, llama a otros dos casos de uso:
  - GetPokemonListUseCase → trae la lista de pokémon de esa generación desde el datasource remoto (API GraphQL).
  - GetHonorRollPokemonsUseCase → trae los pokémon guardados en el datasource local (Sembast, la base de datos embebida).
4. Con ambas listas, DetectPokemonsOnHonorRollUseCase compara y marca (isOnHonorRoll = true) los pokémon remotos que ya están guardados localmente.
5. CreatePokemonRoomsUseCase agrupa el resultado en 5 salones: fuego, agua, planta, otros, y un salón extra con el cuadro de honor.
6. El controller devuelve esa lista de salonesa mostrando las tarjetas.

Flujo 2 — Agregar o quitar un pokémon del cuad

1. El usuario toca un pokémon en la pantalla.
2. El PokemonOnHonorRollController revisa si ese pokémon ya está en el cuadro de honor (pokemon.isOnHonorRoll).
  - Si ya está → llama a DeletePokemonInHonorRregistro en el datasource local.
  - Si no está → llama a SavePokemonInHonorRollUseCase, que lo guarda en el datasource local.                   3. Cuando termina, el controller invalida al Pf.invalidate), lo que dispara de nuevo el Flujo 1 completo: se vuelve a pedir la lista remota, se vuelve a leer el cuadro de honor actualizado, y la pantalla seredibuja con el cambio reflejado.
                                                                                                                En resumen: los Controllers solo orquestan y gUseCases contienen la lógica de negocio (armarsalones, detectar duplicados, decidir guardar/borrar); y los DataSources son los únicos que hablan con el mundo exterior (API remota o base de datos local). Eaparece en el diagrama, es el que traduce entre JSON y entidades en cada uno de esos pasos.

                                                                                
Diagrama de secuencia:
sequenceDiagram
    autonumber
    actor Usuario
    participant C as Controllers
    participant UC as UseCases
    participant DS as DataSources

    Note over Usuario,DS: Flujo 1 - Cargar salones de Pokemon
    Usuario->>C: Abre pantalla / selecciona generacion
    activate C
    C->>UC: createPokemonRooms(generation)
    activate UC

    UC->>DS: getPokemonList(generation) [Remo
    activate DS
    DS-->>UC: JSON pokemons
    deactivate DS

    UC->>DS: getAllPokemons() [Local - Sembast]
    activate DS
    DS-->>UC: JSON cuadro de honor
    deactivate DS

    UC->>UC: detectPokemonsOnHonorRoll()
    UC->>UC: agrupa por tipo (fuego, agua, planta, otros)

    UC-->>C: List PokemonRoomEntity
    deactivate UC
    C-->>Usuario: Renderiza salones
    deactivate C

    Note over Usuario,DS: Flujo 2 - Agregar or
    Usuario->>C: Toca un pokemon
    activate C
    C->>UC: savePokemonInHonorRoll o deletePokemonInHonorRoll
    activate UC

    alt Pokemon ya esta en el cuadro de honor
        UC->>DS: deletePokemon(id) [Local - Sembast]
        activate DS
        DS-->>UC: OK
        deactivate DS
    else Pokemon no esta en el cuadro de honor
        UC->>DS: savePokemon(json) [Local - S
        activate DS
        DS-->>UC: OK
        deactivate DS
    end

    UC-->>C: bool isOnHonorRoll
    deactivate UC
    C->>C: invalidate(pokemonRoomsControllerP
    C-->>Usuario: Actualiza UI
    deactivate C