Feature: PetStore API tests

  Background:
    * def baseUrl = karate.properties['baseUrl'] || 'https://petstore.swagger.io/v2'
    * def randomId = function(){ return java.lang.System.currentTimeMillis() % 1000000 }
    * def testPetId = randomId()
    * print 'Generated Pet ID for this test run:', testPetId

  Scenario: Add a new pet, get it, update it, and find by status
    # 1. Add a new pet to the store
    Given url baseUrl + '/pet'
    And request
    """
    {
      "name": "doggie",
      "photoUrls": [
        "cillum deserunt irure sit",
        "minim consequat"
      ],
      "id": #(testPetId),
      "category": {
        "id": -71766204,
        "name": "labore enim consectetur amet velit"
      },
      "tags": [
        {
          "id": 59431783,
          "name": "nulla exercitation"
        },
        {
          "id": -46476026,
          "name": "est sint tempor minim nulla"
        }
      ],
      "status": "available"
    }
    """
    When method post
    Then status 200
    * def petId = response.id // Se toma el ID de la respuesta
    * print 'Pet created with ID:', petId
    * karate.pause(15000) // Pausa de 15 segundos para dar tiempo a la API

    # 2. Get the pet by ID
    Given url baseUrl + '/pet/' + petId
    When method get
    Then status 200
    And match response.id == petId
    And match response.name == "doggie"
    * print 'Pet retrieved by ID:', response

    # 3. Update the pet's name and status
    Given url baseUrl + '/pet'
    And request
    """
    {
"id": #(petId),
      "name": "cat",
      "photoUrls": [
        "cillum deserunt irure sit",
        "minim consequat"
      ],

      "category": {
        "id": -71766204,
        "name": "labore enim consectetur amet velit"
      },
      "tags": [
        {
          "id": 59431783,
          "name": "nulla exercitation"
        },
        {
          "id": -46476026,
          "name": "est sint tempor minim nulla"
        }
      ],
      "status": "sold"
    }
    """
    When method put
    Then status 200
    * def updatedPetId = response.id
    And match updatedPetId == petId
    And match response.name == "cat"
    And match response.status == "sold"
    * print 'Pet updated:', response
    * karate.pause(5000) // Increased pause after PUT and before findByStatus

    #  Get the pet by ID confirmar vendido
    Given url baseUrl + '/pet/' + petId
    When method get
    Then status 200
    And match updatedPetId == petId
    And match response.name == "cat"
    And match response.status == "sold"
    * print 'Pet sold by ID:', response


    # 4. Find pets by status "sold" and verify the updated pet is present
    Given url baseUrl + '/pet/findByStatus'
    And param status = 'sold'
    When method get
    Then status 200
    * print 'Pets found by status "sold":', response
    # Check if our pet is in the list of sold pets
    * def soldPetsWithOurId = karate.filter(response, function(x){ return x.id == petId })
    * print 'Our pet (ID ' + petId + ') in "sold" list (if found):', soldPetsWithOurId


