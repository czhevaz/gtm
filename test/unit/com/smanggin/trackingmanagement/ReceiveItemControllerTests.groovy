package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * ReceiveItemControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(ReceiveItemController)
@Mock(ReceiveItem)
class ReceiveItemControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/receiveItem/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.receiveItemInstanceList.size() == 0
        assert model.receiveItemInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.receiveItemInstance != null
    }

    void testSave() {
        controller.save()

        assert model.receiveItemInstance != null
        assert view == '/receiveItem/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/receiveItem/show/1'
        assert controller.flash.message != null
        assert ReceiveItem.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/receiveItem/list'


        populateValidParams(params)
        def receiveItem = new ReceiveItem(params)

        assert receiveItem.save() != null

        params.id = receiveItem.id

        def model = controller.show()

        assert model.receiveItemInstance == receiveItem
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/receiveItem/list'


        populateValidParams(params)
        def receiveItem = new ReceiveItem(params)

        assert receiveItem.save() != null

        params.id = receiveItem.id

        def model = controller.edit()

        assert model.receiveItemInstance == receiveItem
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/receiveItem/list'

        response.reset()


        populateValidParams(params)
        def receiveItem = new ReceiveItem(params)

        assert receiveItem.save() != null

        // test invalid parameters in update
        params.id = receiveItem.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/receiveItem/edit"
        assert model.receiveItemInstance != null

        receiveItem.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/receiveItem/show/$receiveItem.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        receiveItem.clearErrors()

        populateValidParams(params)
        params.id = receiveItem.id
        params.version = -1
        controller.update()

        assert view == "/receiveItem/edit"
        assert model.receiveItemInstance != null
        assert model.receiveItemInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/receiveItem/list'

        response.reset()

        populateValidParams(params)
        def receiveItem = new ReceiveItem(params)

        assert receiveItem.save() != null
        assert ReceiveItem.count() == 1

        params.id = receiveItem.id

        controller.delete()

        assert ReceiveItem.count() == 0
        assert ReceiveItem.get(receiveItem.id) == null
        assert response.redirectedUrl == '/receiveItem/list'
    }
}
