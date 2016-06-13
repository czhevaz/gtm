package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QcAfkirControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QcAfkirController)
@Mock(QcAfkir)
class QcAfkirControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/qcAfkir/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.qcAfkirInstanceList.size() == 0
        assert model.qcAfkirInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.qcAfkirInstance != null
    }

    void testSave() {
        controller.save()

        assert model.qcAfkirInstance != null
        assert view == '/qcAfkir/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/qcAfkir/show/1'
        assert controller.flash.message != null
        assert QcAfkir.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkir/list'


        populateValidParams(params)
        def qcAfkir = new QcAfkir(params)

        assert qcAfkir.save() != null

        params.id = qcAfkir.id

        def model = controller.show()

        assert model.qcAfkirInstance == qcAfkir
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkir/list'


        populateValidParams(params)
        def qcAfkir = new QcAfkir(params)

        assert qcAfkir.save() != null

        params.id = qcAfkir.id

        def model = controller.edit()

        assert model.qcAfkirInstance == qcAfkir
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkir/list'

        response.reset()


        populateValidParams(params)
        def qcAfkir = new QcAfkir(params)

        assert qcAfkir.save() != null

        // test invalid parameters in update
        params.id = qcAfkir.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/qcAfkir/edit"
        assert model.qcAfkirInstance != null

        qcAfkir.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/qcAfkir/show/$qcAfkir.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        qcAfkir.clearErrors()

        populateValidParams(params)
        params.id = qcAfkir.id
        params.version = -1
        controller.update()

        assert view == "/qcAfkir/edit"
        assert model.qcAfkirInstance != null
        assert model.qcAfkirInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/qcAfkir/list'

        response.reset()

        populateValidParams(params)
        def qcAfkir = new QcAfkir(params)

        assert qcAfkir.save() != null
        assert QcAfkir.count() == 1

        params.id = qcAfkir.id

        controller.delete()

        assert QcAfkir.count() == 0
        assert QcAfkir.get(qcAfkir.id) == null
        assert response.redirectedUrl == '/qcAfkir/list'
    }
}
