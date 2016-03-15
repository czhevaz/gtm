package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QCActionsControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QCActionsController)
@Mock(QCActions)
class QCActionsControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/QCActions/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.QCActionsInstanceList.size() == 0
        assert model.QCActionsInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.QCActionsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.QCActionsInstance != null
        assert view == '/QCActions/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/QCActions/show/1'
        assert controller.flash.message != null
        assert QCActions.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/QCActions/list'


        populateValidParams(params)
        def QCActions = new QCActions(params)

        assert QCActions.save() != null

        params.id = QCActions.id

        def model = controller.show()

        assert model.QCActionsInstance == QCActions
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/QCActions/list'


        populateValidParams(params)
        def QCActions = new QCActions(params)

        assert QCActions.save() != null

        params.id = QCActions.id

        def model = controller.edit()

        assert model.QCActionsInstance == QCActions
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/QCActions/list'

        response.reset()


        populateValidParams(params)
        def QCActions = new QCActions(params)

        assert QCActions.save() != null

        // test invalid parameters in update
        params.id = QCActions.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/QCActions/edit"
        assert model.QCActionsInstance != null

        QCActions.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/QCActions/show/$QCActions.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        QCActions.clearErrors()

        populateValidParams(params)
        params.id = QCActions.id
        params.version = -1
        controller.update()

        assert view == "/QCActions/edit"
        assert model.QCActionsInstance != null
        assert model.QCActionsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/QCActions/list'

        response.reset()

        populateValidParams(params)
        def QCActions = new QCActions(params)

        assert QCActions.save() != null
        assert QCActions.count() == 1

        params.id = QCActions.id

        controller.delete()

        assert QCActions.count() == 0
        assert QCActions.get(QCActions.id) == null
        assert response.redirectedUrl == '/QCActions/list'
    }
}
