package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * ReplaceCodeHistoryControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(ReplaceCodeHistoryController)
@Mock(ReplaceCodeHistory)
class ReplaceCodeHistoryControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/replaceCodeHistory/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.replaceCodeHistoryInstanceList.size() == 0
        assert model.replaceCodeHistoryInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.replaceCodeHistoryInstance != null
    }

    void testSave() {
        controller.save()

        assert model.replaceCodeHistoryInstance != null
        assert view == '/replaceCodeHistory/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/replaceCodeHistory/show/1'
        assert controller.flash.message != null
        assert ReplaceCodeHistory.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/replaceCodeHistory/list'


        populateValidParams(params)
        def replaceCodeHistory = new ReplaceCodeHistory(params)

        assert replaceCodeHistory.save() != null

        params.id = replaceCodeHistory.id

        def model = controller.show()

        assert model.replaceCodeHistoryInstance == replaceCodeHistory
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/replaceCodeHistory/list'


        populateValidParams(params)
        def replaceCodeHistory = new ReplaceCodeHistory(params)

        assert replaceCodeHistory.save() != null

        params.id = replaceCodeHistory.id

        def model = controller.edit()

        assert model.replaceCodeHistoryInstance == replaceCodeHistory
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/replaceCodeHistory/list'

        response.reset()


        populateValidParams(params)
        def replaceCodeHistory = new ReplaceCodeHistory(params)

        assert replaceCodeHistory.save() != null

        // test invalid parameters in update
        params.id = replaceCodeHistory.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/replaceCodeHistory/edit"
        assert model.replaceCodeHistoryInstance != null

        replaceCodeHistory.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/replaceCodeHistory/show/$replaceCodeHistory.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        replaceCodeHistory.clearErrors()

        populateValidParams(params)
        params.id = replaceCodeHistory.id
        params.version = -1
        controller.update()

        assert view == "/replaceCodeHistory/edit"
        assert model.replaceCodeHistoryInstance != null
        assert model.replaceCodeHistoryInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/replaceCodeHistory/list'

        response.reset()

        populateValidParams(params)
        def replaceCodeHistory = new ReplaceCodeHistory(params)

        assert replaceCodeHistory.save() != null
        assert ReplaceCodeHistory.count() == 1

        params.id = replaceCodeHistory.id

        controller.delete()

        assert ReplaceCodeHistory.count() == 0
        assert ReplaceCodeHistory.get(replaceCodeHistory.id) == null
        assert response.redirectedUrl == '/replaceCodeHistory/list'
    }
}
