import RecipeGenerator from './components/RecipeGenerator/RecipeGenerator'
import Header from './components/Header/Header'

import './App.css'

function App() {
  
  return (
    <>
      <Header />
      <div className="app">
        <h1>Hello, visitor!</h1>
        <RecipeGenerator />
      </div>
    </>
  )
}

export default App
