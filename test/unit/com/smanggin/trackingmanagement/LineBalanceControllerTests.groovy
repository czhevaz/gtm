package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * LineBalanceControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(LineBalanceController)
@Mock(LineBalance)
class LineBalanceControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/lineBalance/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.lineBalanceInstanceList.size() == 0
        assert model.lineBalanceInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.lineBalanceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.lineBalanceInstance != null
        assert view == '/lineBalance/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/lineBalance/show/1'
        assert controller.flash.message != null
        assert LineBalance.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/lineBalance/list'


        populateValidParams(params)
        def lineBalance = new LineBalance(params)

        assert lineBalance.save() != null

        params.id = lineBalance.id

        def model = controller.show()

        assert model.lineBalanceInstance == lineBalance
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/lineBalance/list'


        populateValidParams(params)
        def lineBalance = new LineBalance(params)

        assert lineBalance.save() != null

        params.id = lineBalance.id

        def model = controller.edit()

        assert model.lineBalanceInstance == lineBalance
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/lineBalance/list'

        response.reset()


        populateValidParams(params)
        def lineBalance = new LineBalance(params)

        assert lineBalance.save() != null

        // test invalid parameters in update
        params.id = lineBalance.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/lineBalance/edit"
        assert model.lineBalanceInstance != null

        lineBalance.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/lineBalance/show/$lineBalance.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        lineBalance.clearErrors()

        populateValidParams(params)
        params.id = lineBalance.id
        params.version = -1
        controller.update()

        assert view == "/lineBalance/edit"
        assert model.lineBalanceInstance != null
        assert model.lineBalanceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/lineBalance/list'

        response.reset()

        populateValidParams(params)
        def lineBalance = new LineBalance(params)

        assert lineBalance.save() != null
        assert LineBalance.count() == 1

        params.id = lineBalance.id

        controller.delete()

        assert LineBalance.count() == 0
        assert LineBalance.get(lineBalance.id) == null
        assert response.redirectedUrl == '/lineBalance/list'
    }
}
