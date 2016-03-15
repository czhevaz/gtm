package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QCOptionsControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QCOptionsController)
@Mock(QCOptions)
class QCOptionsControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/QCOptions/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.QCOptionsInstanceList.size() == 0
        assert model.QCOptionsInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.QCOptionsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.QCOptionsInstance != null
        assert view == '/QCOptions/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/QCOptions/show/1'
        assert controller.flash.message != null
        assert QCOptions.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/QCOptions/list'


        populateValidParams(params)
        def QCOptions = new QCOptions(params)

        assert QCOptions.save() != null

        params.id = QCOptions.id

        def model = controller.show()

        assert model.QCOptionsInstance == QCOptions
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/QCOptions/list'


        populateValidParams(params)
        def QCOptions = new QCOptions(params)

        assert QCOptions.save() != null

        params.id = QCOptions.id

        def model = controller.edit()

        assert model.QCOptionsInstance == QCOptions
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/QCOptions/list'

        response.reset()


        populateValidParams(params)
        def QCOptions = new QCOptions(params)

        assert QCOptions.save() != null

        // test invalid parameters in update
        params.id = QCOptions.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/QCOptions/edit"
        assert model.QCOptionsInstance != null

        QCOptions.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/QCOptions/show/$QCOptions.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        QCOptions.clearErrors()

        populateValidParams(params)
        params.id = QCOptions.id
        params.version = -1
        controller.update()

        assert view == "/QCOptions/edit"
        assert model.QCOptionsInstance != null
        assert model.QCOptionsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/QCOptions/list'

        response.reset()

        populateValidParams(params)
        def QCOptions = new QCOptions(params)

        assert QCOptions.save() != null
        assert QCOptions.count() == 1

        params.id = QCOptions.id

        controller.delete()

        assert QCOptions.count() == 0
        assert QCOptions.get(QCOptions.id) == null
        assert response.redirectedUrl == '/QCOptions/list'
    }
}
