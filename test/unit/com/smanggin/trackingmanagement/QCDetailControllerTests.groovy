package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QCDetailControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QCDetailController)
@Mock(QCDetail)
class QCDetailControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/QCDetail/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.QCDetailInstanceList.size() == 0
        assert model.QCDetailInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.QCDetailInstance != null
    }

    void testSave() {
        controller.save()

        assert model.QCDetailInstance != null
        assert view == '/QCDetail/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/QCDetail/show/1'
        assert controller.flash.message != null
        assert QCDetail.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/QCDetail/list'


        populateValidParams(params)
        def QCDetail = new QCDetail(params)

        assert QCDetail.save() != null

        params.id = QCDetail.id

        def model = controller.show()

        assert model.QCDetailInstance == QCDetail
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/QCDetail/list'


        populateValidParams(params)
        def QCDetail = new QCDetail(params)

        assert QCDetail.save() != null

        params.id = QCDetail.id

        def model = controller.edit()

        assert model.QCDetailInstance == QCDetail
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/QCDetail/list'

        response.reset()


        populateValidParams(params)
        def QCDetail = new QCDetail(params)

        assert QCDetail.save() != null

        // test invalid parameters in update
        params.id = QCDetail.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/QCDetail/edit"
        assert model.QCDetailInstance != null

        QCDetail.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/QCDetail/show/$QCDetail.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        QCDetail.clearErrors()

        populateValidParams(params)
        params.id = QCDetail.id
        params.version = -1
        controller.update()

        assert view == "/QCDetail/edit"
        assert model.QCDetailInstance != null
        assert model.QCDetailInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/QCDetail/list'

        response.reset()

        populateValidParams(params)
        def QCDetail = new QCDetail(params)

        assert QCDetail.save() != null
        assert QCDetail.count() == 1

        params.id = QCDetail.id

        controller.delete()

        assert QCDetail.count() == 0
        assert QCDetail.get(QCDetail.id) == null
        assert response.redirectedUrl == '/QCDetail/list'
    }
}
