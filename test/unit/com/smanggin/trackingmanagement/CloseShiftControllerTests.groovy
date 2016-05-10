package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * CloseShiftControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(CloseShiftController)
@Mock(CloseShift)
class CloseShiftControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/closeShift/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.closeShiftInstanceList.size() == 0
        assert model.closeShiftInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.closeShiftInstance != null
    }

    void testSave() {
        controller.save()

        assert model.closeShiftInstance != null
        assert view == '/closeShift/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/closeShift/show/1'
        assert controller.flash.message != null
        assert CloseShift.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/closeShift/list'


        populateValidParams(params)
        def closeShift = new CloseShift(params)

        assert closeShift.save() != null

        params.id = closeShift.id

        def model = controller.show()

        assert model.closeShiftInstance == closeShift
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/closeShift/list'


        populateValidParams(params)
        def closeShift = new CloseShift(params)

        assert closeShift.save() != null

        params.id = closeShift.id

        def model = controller.edit()

        assert model.closeShiftInstance == closeShift
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/closeShift/list'

        response.reset()


        populateValidParams(params)
        def closeShift = new CloseShift(params)

        assert closeShift.save() != null

        // test invalid parameters in update
        params.id = closeShift.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/closeShift/edit"
        assert model.closeShiftInstance != null

        closeShift.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/closeShift/show/$closeShift.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        closeShift.clearErrors()

        populateValidParams(params)
        params.id = closeShift.id
        params.version = -1
        controller.update()

        assert view == "/closeShift/edit"
        assert model.closeShiftInstance != null
        assert model.closeShiftInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/closeShift/list'

        response.reset()

        populateValidParams(params)
        def closeShift = new CloseShift(params)

        assert closeShift.save() != null
        assert CloseShift.count() == 1

        params.id = closeShift.id

        controller.delete()

        assert CloseShift.count() == 0
        assert CloseShift.get(closeShift.id) == null
        assert response.redirectedUrl == '/closeShift/list'
    }
}
