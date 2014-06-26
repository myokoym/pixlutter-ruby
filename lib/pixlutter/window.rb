require "clutter"
require "gdk_pixbuf2"

module Pixlutter
  class Window
    attr_reader :files
    def initialize(file)
      @files = [file]
      @stage = create_stage
      @box = create_box(@stage)
      @image = create_image(@box)
      set_data(@image, @files.first)
    end

    def add_file(file)
      @files << file
    end

    def add_files(files)
      @files += files
    end

    def main
      @stage.show
      Clutter.main
    end

    private
    def create_stage
      stage = Clutter::Stage.new
      stage.name = "Stage"
      stage.title = "Content Box"
      stage.user_resizable = true
      stage.background_color = Clutter::Color.get_static(:aluminium_1)
      stage.signal_connect("destroy") do
        Clutter.main_quit
      end
      stage.signal_connect("key-press-event") do |_actor, event|
        case event.key_symbol
        when Clutter::Keys::KEY_n
          @files.push(@files.shift)
          set_data(@image, @files.first)
        when Clutter::Keys::KEY_p
          @files.unshift(@files.pop)
          set_data(@image, @files.first)
        when Clutter::Keys::KEY_s
          spin(@box)
        when Clutter::Keys::KEY_z
          zoom(@box)
        end
      end
      stage
    end

    def create_box(stage)
      box = Clutter::Actor.new
      box.name = "Image"
      box.add_constraint(Clutter::BindConstraint.new(stage, :size, 0.0))
      box.set_content_scaling_filters(:trilinear, :linear)
      box.set_pivot_point(0.5, 0.0)
      box.reactive = true
      stage.add_child(box)
      box
    end

    def create_image(box)
      image = Clutter::Image.new
      box.set_content(image)
      image
    end

    def set_data(image, file)
      pixbuf = Gdk::Pixbuf.new(File.expand_path(file))
      image.set_data(pixbuf.pixels,
                     pixbuf.has_alpha? ? :rgba_8888 : :rgb_888,
                     pixbuf.width,
                     pixbuf.height,
                     pixbuf.rowstride)
    end

    def spin(actor)
      actor.save_easing_state do
        @angle ||= 0.0
        @angle = @angle == 0.0 ? 360.0 : 0.0
        actor.easing_duration = 10000
        actor.easing_delay = 100
        actor.easing_mode = :linear
        actor.set_rotation_angle(:y_axis, @angle)
      end
      Clutter::Event::STOP
    end

    def zoom(actor)
      actor.save_easing_state do
        @zpos ||= 0.0
        @zpos = @zpos == 0.0 ? -500.0 : 0.0
        actor.easing_duration = 1000
        actor.easing_mode = :ease_out_bounce
        #actor.easing_mode = :ease_in_out
        actor.z_position = @zpos
      end
      Clutter::Event::STOP
    end
  end
end
