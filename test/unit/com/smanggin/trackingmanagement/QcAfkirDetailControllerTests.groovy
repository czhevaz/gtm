package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QcAfkirDetailControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QcAfkirDetailController)
@Mock(QcAfkirDetail)
class QcAfkirDetailControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/qcAfkirDetail/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.qcAfkirDetailInstanceList.size() == 0
        assert model.qcAfkirDetailInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.qcAfkirDetailInstance != null
    }

    void testSave() {
        controller.save()

        assert model.qcAfkirDetailInstance != null
        assert view == '/qcAfkirDetail/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/qcAfkirDetail/show/1'
        assert controller.flash.message != null
        assert QcAfkirDetail.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkirDetail/list'


        populateValidParams(params)
        def qcAfkirDetail = new QcAfkirDetail(params)

        assert qcAfkirDetail.save() != null

        params.id = qcAfkirDetail.id

        def model = controller.show()

        assert model.qcAfkirDetailInstance == qcAfkirDetail
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkirDetail/list'


        populateValidParams(params)
        def qcAfkirDetail = new QcAfkirDetail(params)

        assert qcAfkirDetail.save() != null

        params.id = qcAfkirDetail.id

        def model = controller.edit()

        assert model.qcAfkirDetailInstance == qcAfkirDetail
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkirDetail/list'

        response.reset()


        populateValidParams(params)
        def qcAfkirDetail = new QcAfkirDetail(params)

        assert qcAfkirDetail.save() != null

        // test invalid parameters in update
        params.id = qcAfkirDetail.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/qcAfkirDetail/edit"
        assert model.qcAfkirDetailInstance != null

        qcAfkirDetail.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/qcAfkirDetail/show/$qcAfkirDetail.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        qcAfkirDetail.clearErrors()

        populateValidParams(params)
        params.id = qcAfkirDetail.id
        params.version = -1
        controller.update()

        assert view == "/qcAfkirDetail/edit"
        assert model.qcAfkirDetailInstance != null
        assert model.qcAfkirDetailInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkirDetail/list'

        response.reset()

        populateValidParams(params)
        def qcAfkirDetail = new QcAfkirDetail(params)

        assert qcAfkirDetail.save() != null
        assert QcAfkirDetail.count() == 1

        params.id = qcAfkirDetail.id

        controller.delete()

        assert QcAfkirDetail.count() == 0
        assert QcAfkirDetail.get(qcAfkirDetail.id) == null
        assert response.redirectedUrl == '/qcAfkirDetail/list'
    }
}
