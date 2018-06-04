module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = { autolink: true,
                no_intra_emphasis: true,
                fenced_code_blocks: true,
                lax_html_blocks: true,
                strikethrough: true,
                superscript: true,
                space_after_headers: true }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association)
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('shared/' + association.to_s.singularize + '_fields', f: builder)
    end
    link_to(name, '#', class: 'add_fields', data: { id: id, fields: fields.gsub("\n", "") })
  end
end
