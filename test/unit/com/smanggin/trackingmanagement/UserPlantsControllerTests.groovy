package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * UserPlantsControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(UserPlantsController)
@Mock(UserPlants)
class UserPlantsControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/userPlants/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.userPlantsInstanceList.size() == 0
        assert model.userPlantsInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.userPlantsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.userPlantsInstance != null
        assert view == '/userPlants/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/userPlants/show/1'
        assert controller.flash.message != null
        assert UserPlants.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/userPlants/list'


        populateValidParams(params)
        def userPlants = new UserPlants(params)

        assert userPlants.save() != null

        params.id = userPlants.id

        def model = controller.show()

        assert model.userPlantsInstance == userPlants
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/userPlants/list'


        populateValidParams(params)
        def userPlants = new UserPlants(params)

        assert userPlants.save() != null

        params.id = userPlants.id

        def model = controller.edit()

        assert model.userPlantsInstance == userPlants
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/userPlants/list'

        response.reset()


        populateValidParams(params)
        def userPlants = new UserPlants(params)

        assert userPlants.save() != null

        // test invalid parameters in update
        params.id = userPlants.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/userPlants/edit"
        assert model.userPlantsInstance != null

        userPlants.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/userPlants/show/$userPlants.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        userPlants.clearErrors()

        populateValidParams(params)
        params.id = userPlants.id
        params.version = -1
        controller.update()

        assert view == "/userPlants/edit"
        assert model.userPlantsInstance != null
        assert model.userPlantsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/userPlants/list'

        response.reset()

        populateValidParams(params)
        def userPlants = new UserPlants(params)

        assert userPlants.save() != null
        assert UserPlants.count() == 1

        params.id = userPlants.id

        controller.delete()

        assert UserPlants.count() == 0
        assert UserPlants.get(userPlants.id) == null
        assert response.redirectedUrl == '/userPlants/list'
    }
}
