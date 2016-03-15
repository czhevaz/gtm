package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * WorkCenterControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(WorkCenterController)
@Mock(WorkCenter)
class WorkCenterControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/workCenter/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.workCenterInstanceList.size() == 0
        assert model.workCenterInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.workCenterInstance != null
    }

    void testSave() {
        controller.save()

        assert model.workCenterInstance != null
        assert view == '/workCenter/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/workCenter/show/1'
        assert controller.flash.message != null
        assert WorkCenter.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/workCenter/list'


        populateValidParams(params)
        def workCenter = new WorkCenter(params)

        assert workCenter.save() != null

        params.id = workCenter.id

        def model = controller.show()

        assert model.workCenterInstance == workCenter
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/workCenter/list'


        populateValidParams(params)
        def workCenter = new WorkCenter(params)

        assert workCenter.save() != null

        params.id = workCenter.id

        def model = controller.edit()

        assert model.workCenterInstance == workCenter
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/workCenter/list'

        response.reset()


        populateValidParams(params)
        def workCenter = new WorkCenter(params)

        assert workCenter.save() != null

        // test invalid parameters in update
        params.id = workCenter.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/workCenter/edit"
        assert model.workCenterInstance != null

        workCenter.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/workCenter/show/$workCenter.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        workCenter.clearErrors()

        populateValidParams(params)
        params.id = workCenter.id
        params.version = -1
        controller.update()

        assert view == "/workCenter/edit"
        assert model.workCenterInstance != null
        assert model.workCenterInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/workCenter/list'

        response.reset()

        populateValidParams(params)
        def workCenter = new WorkCenter(params)

        assert workCenter.save() != null
        assert WorkCenter.count() == 1

        params.id = workCenter.id

        controller.delete()

        assert WorkCenter.count() == 0
        assert WorkCenter.get(workCenter.id) == null
        assert response.redirectedUrl == '/workCenter/list'
    }
}
