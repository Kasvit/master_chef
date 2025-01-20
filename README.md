# Master Chef App

This application allows users to input ingredients and receive a recipe generated by AI that they can cook.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Kasvit/master_chef.git
   ```

2. Navigate to the project directory:
   ```bash
   cd master_chef
   ```

3. Install dependencies:
   ```bash
   bundle install
   rake db:create
   npm install
   cd client && npm install
   ```

## Usage

1. Create a `.env` file in the root directory.

2. Start the application:
   ```bash
   # Option 1: Run servers separately
   bundle exec rails s
   cd client && npm run dev
   
   # Option 2: Run both servers with foreman
   foreman start -f Procfile.dev
   ```

3. Open your browser and go to `http://localhost:5173`.

4. Enter your ingredients in the provided field.

5. Click the button to receive a recipe.

## Technologies

- Ruby on Rails
- React
- For recipe generation: OpenAI API, Claude API, Groq API

## Contributing

If you would like to contribute to the project, please create a new pull request.

### TODO:
- [ ] Add AI clients
- [x] Config foreman
- [x] Add a checkbox on UI to allow the AI to use additional ingredients Feel free to use any other ingredients that you can find in your kitchen.
- [x] Add tailwind, update styles
- [x] Add CI
- [ ] Validate the generated recipe
- [ ] Add swagger documentation
- [ ] Add storybooks https://storybook.js.org/docs/get-started/frameworks/react-vite
- [ ] Deploy