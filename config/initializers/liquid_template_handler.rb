require 'action_view/template/handlers/liquid'
ActionView::Template.register_template_handler:md,
  ActionView::Template::Handlers::Liquid
