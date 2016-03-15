package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * TransactionGroupControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(TransactionGroupController)
@Mock(TransactionGroup)
class TransactionGroupControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/transactionGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.transactionGroupInstanceList.size() == 0
        assert model.transactionGroupInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.transactionGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.transactionGroupInstance != null
        assert view == '/transactionGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/transactionGroup/show/1'
        assert controller.flash.message != null
        assert TransactionGroup.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/transactionGroup/list'


        populateValidParams(params)
        def transactionGroup = new TransactionGroup(params)

        assert transactionGroup.save() != null

        params.id = transactionGroup.id

        def model = controller.show()

        assert model.transactionGroupInstance == transactionGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/transactionGroup/list'


        populateValidParams(params)
        def transactionGroup = new TransactionGroup(params)

        assert transactionGroup.save() != null

        params.id = transactionGroup.id

        def model = controller.edit()

        assert model.transactionGroupInstance == transactionGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/transactionGroup/list'

        response.reset()


        populateValidParams(params)
        def transactionGroup = new TransactionGroup(params)

        assert transactionGroup.save() != null

        // test invalid parameters in update
        params.id = transactionGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/transactionGroup/edit"
        assert model.transactionGroupInstance != null

        transactionGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/transactionGroup/show/$transactionGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        transactionGroup.clearErrors()

        populateValidParams(params)
        params.id = transactionGroup.id
        params.version = -1
        controller.update()

        assert view == "/transactionGroup/edit"
        assert model.transactionGroupInstance != null
        assert model.transactionGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/transactionGroup/list'

        response.reset()

        populateValidParams(params)
        def transactionGroup = new TransactionGroup(params)

        assert transactionGroup.save() != null
        assert TransactionGroup.count() == 1

        params.id = transactionGroup.id

        controller.delete()

        assert TransactionGroup.count() == 0
        assert TransactionGroup.get(transactionGroup.id) == null
        assert response.redirectedUrl == '/transactionGroup/list'
    }
}
