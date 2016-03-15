package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * QCQuestionsControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(QCQuestionsController)
@Mock(QCQuestions)
class QCQuestionsControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/QCQuestions/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.QCQuestionsInstanceList.size() == 0
        assert model.QCQuestionsInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.QCQuestionsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.QCQuestionsInstance != null
        assert view == '/QCQuestions/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/QCQuestions/show/1'
        assert controller.flash.message != null
        assert QCQuestions.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/QCQuestions/list'


        populateValidParams(params)
        def QCQuestions = new QCQuestions(params)

        assert QCQuestions.save() != null

        params.id = QCQuestions.id

        def model = controller.show()

        assert model.QCQuestionsInstance == QCQuestions
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/QCQuestions/list'


        populateValidParams(params)
        def QCQuestions = new QCQuestions(params)

        assert QCQuestions.save() != null

        params.id = QCQuestions.id

        def model = controller.edit()

        assert model.QCQuestionsInstance == QCQuestions
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/QCQuestions/list'

        response.reset()


        populateValidParams(params)
        def QCQuestions = new QCQuestions(params)

        assert QCQuestions.save() != null

        // test invalid parameters in update
        params.id = QCQuestions.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/QCQuestions/edit"
        assert model.QCQuestionsInstance != null

        QCQuestions.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/QCQuestions/show/$QCQuestions.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        QCQuestions.clearErrors()

        populateValidParams(params)
        params.id = QCQuestions.id
        params.version = -1
        controller.update()

        assert view == "/QCQuestions/edit"
        assert model.QCQuestionsInstance != null
        assert model.QCQuestionsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/QCQuestions/list'

        response.reset()

        populateValidParams(params)
        def QCQuestions = new QCQuestions(params)

        assert QCQuestions.save() != null
        assert QCQuestions.count() == 1

        params.id = QCQuestions.id

        controller.delete()

        assert QCQuestions.count() == 0
        assert QCQuestions.get(QCQuestions.id) == null
        assert response.redirectedUrl == '/QCQuestions/list'
    }
}
