package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QCHeaderControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QCHeaderController)
@Mock(QCHeader)
class QCHeaderControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/QCHeader/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.QCHeaderInstanceList.size() == 0
        assert model.QCHeaderInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.QCHeaderInstance != null
    }

    void testSave() {
        controller.save()

        assert model.QCHeaderInstance != null
        assert view == '/QCHeader/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/QCHeader/show/1'
        assert controller.flash.message != null
        assert QCHeader.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/QCHeader/list'


        populateValidParams(params)
        def QCHeader = new QCHeader(params)

        assert QCHeader.save() != null

        params.id = QCHeader.id

        def model = controller.show()

        assert model.QCHeaderInstance == QCHeader
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/QCHeader/list'


        populateValidParams(params)
        def QCHeader = new QCHeader(params)

        assert QCHeader.save() != null

        params.id = QCHeader.id

        def model = controller.edit()

        assert model.QCHeaderInstance == QCHeader
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/QCHeader/list'

        response.reset()


        populateValidParams(params)
        def QCHeader = new QCHeader(params)

        assert QCHeader.save() != null

        // test invalid parameters in update
        params.id = QCHeader.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/QCHeader/edit"
        assert model.QCHeaderInstance != null

        QCHeader.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/QCHeader/show/$QCHeader.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        QCHeader.clearErrors()

        populateValidParams(params)
        params.id = QCHeader.id
        params.version = -1
        controller.update()

        assert view == "/QCHeader/edit"
        assert model.QCHeaderInstance != null
        assert model.QCHeaderInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/QCHeader/list'

        response.reset()

        populateValidParams(params)
        def QCHeader = new QCHeader(params)

        assert QCHeader.save() != null
        assert QCHeader.count() == 1

        params.id = QCHeader.id

        controller.delete()

        assert QCHeader.count() == 0
        assert QCHeader.get(QCHeader.id) == null
        assert response.redirectedUrl == '/QCHeader/list'
    }
}
