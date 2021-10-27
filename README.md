# Lost Pets Livecode :: ::

Hey All ! Lazy coder here :smirk: ! Congratulations on finishing up your Rails CRUD challenges :rocket: ! 


Please see below a step-by-step guide how we completed the livecode all together.


First of all, let's generate our controller with its action in one line :sleepy:

```console
rails g controller pets index show new create edit update destroy 
```

Then our model :sleepy:

```console
rails g model name address species found_on:date
```


**Route** 

```ruby

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html  
  root to: "pets#index"
  get "/pets/new", to: "pets#new"

  get "/pets/:id", to: "pets#show", as: :pet
  post "/pets", to: "pets#create"

  delete "/pets/:id", to: "pets#destroy"

  get "/pets/:id/edit", to: "pets#edit", as: :edit_pet
  patch "/pets/:id", to: "pets#update"

end

```
**Controller** 

```ruby
class PetsController < ApplicationController
  before_action :find_pet_id, only: [:show, :edit, :destroy, :update]

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def show
  end

  def create
    @pet = Pet.new(set_params)
    if @pet.save
      redirect_to pet_path(@pet)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @pet.update(set_params)
      redirect_to pet_path(@pet)
    else
      render "edit"
    end
  end

  def destroy
    @pet.destroy 
    redirect_to root_path
  end

  private

  def set_params
    params.require(:pet).permit(:name, :address, :species, :found_on)
  end

  def find_pet_id
    @pet = Pet.find(params[:id])
  end
end

```


Our model on this livecode included features that we already saw during our active record courses and challenges, the idea was to have a **fixed list** of species : ```["dog", "cat", "rabbit", "snake", "turtle"]```

**Model**

```ruby
class Pet < ApplicationRecord
    validates :name, presence: true 
    SPECIES = %w(dog cat rabbit snake turtle)
    validates :species, inclusion: {in: SPECIES}
end

```

We can access the list of species in our ```simple_form``` by simply stating ```collection: Pet::SPECIES```


***Our form view***

```ruby
<%= simple_form_for @pet do |f| %>
  <%= f.input :name %>
  <%= f.input :address %>
  <%= f.input :species, collection: Pet::SPECIES %>
  <%= f.input :found_on %>
  <%= f.submit class: "btn btn-primary" %>
<% end %>
```