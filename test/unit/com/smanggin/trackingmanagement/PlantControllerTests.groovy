package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * PlantControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(PlantController)
@Mock(Plant)
class PlantControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/plant/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.plantInstanceList.size() == 0
        assert model.plantInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.plantInstance != null
    }

    void testSave() {
        controller.save()

        assert model.plantInstance != null
        assert view == '/plant/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/plant/show/1'
        assert controller.flash.message != null
        assert Plant.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/plant/list'


        populateValidParams(params)
        def plant = new Plant(params)

        assert plant.save() != null

        params.id = plant.id

        def model = controller.show()

        assert model.plantInstance == plant
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/plant/list'


        populateValidParams(params)
        def plant = new Plant(params)

        assert plant.save() != null

        params.id = plant.id

        def model = controller.edit()

        assert model.plantInstance == plant
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/plant/list'

        response.reset()


        populateValidParams(params)
        def plant = new Plant(params)

        assert plant.save() != null

        // test invalid parameters in update
        params.id = plant.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/plant/edit"
        assert model.plantInstance != null

        plant.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/plant/show/$plant.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        plant.clearErrors()

        populateValidParams(params)
        params.id = plant.id
        params.version = -1
        controller.update()

        assert view == "/plant/edit"
        assert model.plantInstance != null
        assert model.plantInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/plant/list'

        response.reset()

        populateValidParams(params)
        def plant = new Plant(params)

        assert plant.save() != null
        assert Plant.count() == 1

        params.id = plant.id

        controller.delete()

        assert Plant.count() == 0
        assert Plant.get(plant.id) == null
        assert response.redirectedUrl == '/plant/list'
    }
}
