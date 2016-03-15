package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * GallonControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(GallonController)
@Mock(Gallon)
class GallonControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/gallon/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.gallonInstanceList.size() == 0
        assert model.gallonInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.gallonInstance != null
    }

    void testSave() {
        controller.save()

        assert model.gallonInstance != null
        assert view == '/gallon/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/gallon/show/1'
        assert controller.flash.message != null
        assert Gallon.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/gallon/list'


        populateValidParams(params)
        def gallon = new Gallon(params)

        assert gallon.save() != null

        params.id = gallon.id

        def model = controller.show()

        assert model.gallonInstance == gallon
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/gallon/list'


        populateValidParams(params)
        def gallon = new Gallon(params)

        assert gallon.save() != null

        params.id = gallon.id

        def model = controller.edit()

        assert model.gallonInstance == gallon
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/gallon/list'

        response.reset()


        populateValidParams(params)
        def gallon = new Gallon(params)

        assert gallon.save() != null

        // test invalid parameters in update
        params.id = gallon.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/gallon/edit"
        assert model.gallonInstance != null

        gallon.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/gallon/show/$gallon.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        gallon.clearErrors()

        populateValidParams(params)
        params.id = gallon.id
        params.version = -1
        controller.update()

        assert view == "/gallon/edit"
        assert model.gallonInstance != null
        assert model.gallonInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/gallon/list'

        response.reset()

        populateValidParams(params)
        def gallon = new Gallon(params)

        assert gallon.save() != null
        assert Gallon.count() == 1

        params.id = gallon.id

        controller.delete()

        assert Gallon.count() == 0
        assert Gallon.get(gallon.id) == null
        assert response.redirectedUrl == '/gallon/list'
    }
}
