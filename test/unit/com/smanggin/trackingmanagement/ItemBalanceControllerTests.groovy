package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * ItemBalanceControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(ItemBalanceController)
@Mock(ItemBalance)
class ItemBalanceControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/itemBalance/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.itemBalanceInstanceList.size() == 0
        assert model.itemBalanceInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.itemBalanceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.itemBalanceInstance != null
        assert view == '/itemBalance/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/itemBalance/show/1'
        assert controller.flash.message != null
        assert ItemBalance.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/itemBalance/list'


        populateValidParams(params)
        def itemBalance = new ItemBalance(params)

        assert itemBalance.save() != null

        params.id = itemBalance.id

        def model = controller.show()

        assert model.itemBalanceInstance == itemBalance
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/itemBalance/list'


        populateValidParams(params)
        def itemBalance = new ItemBalance(params)

        assert itemBalance.save() != null

        params.id = itemBalance.id

        def model = controller.edit()

        assert model.itemBalanceInstance == itemBalance
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/itemBalance/list'

        response.reset()


        populateValidParams(params)
        def itemBalance = new ItemBalance(params)

        assert itemBalance.save() != null

        // test invalid parameters in update
        params.id = itemBalance.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/itemBalance/edit"
        assert model.itemBalanceInstance != null

        itemBalance.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/itemBalance/show/$itemBalance.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        itemBalance.clearErrors()

        populateValidParams(params)
        params.id = itemBalance.id
        params.version = -1
        controller.update()

        assert view == "/itemBalance/edit"
        assert model.itemBalanceInstance != null
        assert model.itemBalanceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/itemBalance/list'

        response.reset()

        populateValidParams(params)
        def itemBalance = new ItemBalance(params)

        assert itemBalance.save() != null
        assert ItemBalance.count() == 1

        params.id = itemBalance.id

        controller.delete()

        assert ItemBalance.count() == 0
        assert ItemBalance.get(itemBalance.id) == null
        assert response.redirectedUrl == '/itemBalance/list'
    }
}
