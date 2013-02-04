class FamilyMe.Routers.ApplicationRouter extends Backbone.Router
  routes:
    'family'  : 'displayApplication'

  displayApplication:->
    @applicationView ||= new FamilyMe.Views.ApplicationView()

    FamilyMe.UsersList = @collection = new FamilyMe.Collections.Users()

    @collection.fetch
        success: (user, response, options)=>
          @applicationView.render()
        error:->
          alert 'Error loading application... Try to reload this page!'
