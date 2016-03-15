package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * ProcessQCControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(ProcessQCController)
@Mock(ProcessQC)
class ProcessQCControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/processQC/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.processQCInstanceList.size() == 0
        assert model.processQCInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.processQCInstance != null
    }

    void testSave() {
        controller.save()

        assert model.processQCInstance != null
        assert view == '/processQC/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/processQC/show/1'
        assert controller.flash.message != null
        assert ProcessQC.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/processQC/list'


        populateValidParams(params)
        def processQC = new ProcessQC(params)

        assert processQC.save() != null

        params.id = processQC.id

        def model = controller.show()

        assert model.processQCInstance == processQC
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/processQC/list'


        populateValidParams(params)
        def processQC = new ProcessQC(params)

        assert processQC.save() != null

        params.id = processQC.id

        def model = controller.edit()

        assert model.processQCInstance == processQC
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/processQC/list'

        response.reset()


        populateValidParams(params)
        def processQC = new ProcessQC(params)

        assert processQC.save() != null

        // test invalid parameters in update
        params.id = processQC.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/processQC/edit"
        assert model.processQCInstance != null

        processQC.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/processQC/show/$processQC.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        processQC.clearErrors()

        populateValidParams(params)
        params.id = processQC.id
        params.version = -1
        controller.update()

        assert view == "/processQC/edit"
        assert model.processQCInstance != null
        assert model.processQCInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/processQC/list'

        response.reset()

        populateValidParams(params)
        def processQC = new ProcessQC(params)

        assert processQC.save() != null
        assert ProcessQC.count() == 1

        params.id = processQC.id

        controller.delete()

        assert ProcessQC.count() == 0
        assert ProcessQC.get(processQC.id) == null
        assert response.redirectedUrl == '/processQC/list'
    }
}
