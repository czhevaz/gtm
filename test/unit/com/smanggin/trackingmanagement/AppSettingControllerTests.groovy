package com.smanggin.trackingmanagement



import org.junit.*
import grails.test.mixin.*

/**
 * AppSettingControllerTests
 * A unit test class is used to test individual methods or blocks of code without considering the surrounding infrastructure
 */
@TestFor(AppSettingController)
@Mock(AppSetting)
class AppSettingControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/appSetting/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.appSettingInstanceList.size() == 0
        assert model.appSettingInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.appSettingInstance != null
    }

    void testSave() {
        controller.save()

        assert model.appSettingInstance != null
        assert view == '/appSetting/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/appSetting/show/1'
        assert controller.flash.message != null
        assert AppSetting.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/appSetting/list'


        populateValidParams(params)
        def appSetting = new AppSetting(params)

        assert appSetting.save() != null

        params.id = appSetting.id

        def model = controller.show()

        assert model.appSettingInstance == appSetting
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/appSetting/list'


        populateValidParams(params)
        def appSetting = new AppSetting(params)

        assert appSetting.save() != null

        params.id = appSetting.id

        def model = controller.edit()

        assert model.appSettingInstance == appSetting
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/appSetting/list'

        response.reset()


        populateValidParams(params)
        def appSetting = new AppSetting(params)

        assert appSetting.save() != null

        // test invalid parameters in update
        params.id = appSetting.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/appSetting/edit"
        assert model.appSettingInstance != null

        appSetting.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/appSetting/show/$appSetting.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        appSetting.clearErrors()

        populateValidParams(params)
        params.id = appSetting.id
        params.version = -1
        controller.update()

        assert view == "/appSetting/edit"
        assert model.appSettingInstance != null
        assert model.appSettingInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/appSetting/list'

        response.reset()

        populateValidParams(params)
        def appSetting = new AppSetting(params)

        assert appSetting.save() != null
        assert AppSetting.count() == 1

        params.id = appSetting.id

        controller.delete()

        assert AppSetting.count() == 0
        assert AppSetting.get(appSetting.id) == null
        assert response.redirectedUrl == '/appSetting/list'
    }
}
