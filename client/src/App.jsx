import RecipeGenerator from './components/RecipeGenerator/RecipeGenerator'
import Header from './components/Header/Header'

import './App.css'

function App() {
  return (
    <div className="min-h-screen bg-gray-100 mx-auto">
      <Header />
      <main className="container mx-auto px-4 pt-24 pb-8">
        <div className="max-w-3xl mx-auto bg-white rounded-lg shadow-lg p-6">
          <RecipeGenerator />
        </div>
      </main>
    </div>
  )
}

export default App
