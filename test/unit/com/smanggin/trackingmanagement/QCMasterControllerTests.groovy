package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QCMasterControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QCMasterController)
@Mock(QCMaster)
class QCMasterControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/QCMaster/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.QCMasterInstanceList.size() == 0
        assert model.QCMasterInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.QCMasterInstance != null
    }

    void testSave() {
        controller.save()

        assert model.QCMasterInstance != null
        assert view == '/QCMaster/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/QCMaster/show/1'
        assert controller.flash.message != null
        assert QCMaster.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/QCMaster/list'


        populateValidParams(params)
        def QCMaster = new QCMaster(params)

        assert QCMaster.save() != null

        params.id = QCMaster.id

        def model = controller.show()

        assert model.QCMasterInstance == QCMaster
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/QCMaster/list'


        populateValidParams(params)
        def QCMaster = new QCMaster(params)

        assert QCMaster.save() != null

        params.id = QCMaster.id

        def model = controller.edit()

        assert model.QCMasterInstance == QCMaster
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/QCMaster/list'

        response.reset()


        populateValidParams(params)
        def QCMaster = new QCMaster(params)

        assert QCMaster.save() != null

        // test invalid parameters in update
        params.id = QCMaster.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/QCMaster/edit"
        assert model.QCMasterInstance != null

        QCMaster.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/QCMaster/show/$QCMaster.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        QCMaster.clearErrors()

        populateValidParams(params)
        params.id = QCMaster.id
        params.version = -1
        controller.update()

        assert view == "/QCMaster/edit"
        assert model.QCMasterInstance != null
        assert model.QCMasterInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/QCMaster/list'

        response.reset()

        populateValidParams(params)
        def QCMaster = new QCMaster(params)

        assert QCMaster.save() != null
        assert QCMaster.count() == 1

        params.id = QCMaster.id

        controller.delete()

        assert QCMaster.count() == 0
        assert QCMaster.get(QCMaster.id) == null
        assert response.redirectedUrl == '/QCMaster/list'
    }
}
