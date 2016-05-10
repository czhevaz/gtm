package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * ShiftControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(ShiftController)
@Mock(Shift)
class ShiftControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/shift/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.shiftInstanceList.size() == 0
        assert model.shiftInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.shiftInstance != null
    }

    void testSave() {
        controller.save()

        assert model.shiftInstance != null
        assert view == '/shift/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/shift/show/1'
        assert controller.flash.message != null
        assert Shift.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/shift/list'


        populateValidParams(params)
        def shift = new Shift(params)

        assert shift.save() != null

        params.id = shift.id

        def model = controller.show()

        assert model.shiftInstance == shift
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/shift/list'


        populateValidParams(params)
        def shift = new Shift(params)

        assert shift.save() != null

        params.id = shift.id

        def model = controller.edit()

        assert model.shiftInstance == shift
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/shift/list'

        response.reset()


        populateValidParams(params)
        def shift = new Shift(params)

        assert shift.save() != null

        // test invalid parameters in update
        params.id = shift.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/shift/edit"
        assert model.shiftInstance != null

        shift.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/shift/show/$shift.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        shift.clearErrors()

        populateValidParams(params)
        params.id = shift.id
        params.version = -1
        controller.update()

        assert view == "/shift/edit"
        assert model.shiftInstance != null
        assert model.shiftInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/shift/list'

        response.reset()

        populateValidParams(params)
        def shift = new Shift(params)

        assert shift.save() != null
        assert Shift.count() == 1

        params.id = shift.id

        controller.delete()

        assert Shift.count() == 0
        assert Shift.get(shift.id) == null
        assert response.redirectedUrl == '/shift/list'
    }
}
