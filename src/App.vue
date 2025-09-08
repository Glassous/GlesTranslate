<template>
  <div class="min-h-screen p-6 backdrop-filter backdrop-blur-lg bg-opacity-30 bg-base-100 relative">
    <!-- 标题 -->
    <div class="flex items-center mb-8">
      <button 
        @click="historyExpanded = !historyExpanded"
        class="btn btn-ghost btn-circle mr-4"
      >
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
        </svg>
      </button>
      <h1 class="text-5xl font-aladin font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
        GlesTranslate
      </h1>
    </div>

    <!-- 翻译模块 -->
    <div class="w-full mx-auto transition-all duration-300 ease-in-out">
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- 左侧：目标文本框 -->
        <div class="card bg-base-100 shadow-xl">
          <div class="card-body">
            <div class="flex justify-between items-center mb-4">
              <h2 class="card-title text-lg">源语言</h2>
              <div class="badge badge-primary">自动检测</div>
            </div>
            <textarea 
              v-model="sourceText"
              class="textarea textarea-bordered w-full h-48 resize-none"
              placeholder="请输入要翻译的文本..."
              @input="handleInput"
            ></textarea>
            <div class="text-sm text-gray-500 mt-2">
              {{ sourceText.length }} / 5000 字符
            </div>
          </div>
        </div>

        <!-- 右侧：翻译结果 -->
        <div class="card bg-base-100 shadow-xl">
          <div class="card-body">
            <div class="flex justify-between items-center mb-4">
              <h2 class="card-title text-lg">目标语言</h2>
              <div class="dropdown dropdown-end">
                <div tabindex="0" role="button" class="btn btn-sm btn-outline">
                  {{ selectedLanguage.name }}
                  <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                  </svg>
                </div>
                <ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
                  <li v-for="lang in languages" :key="lang.code">
                    <a @click="selectLanguage(lang)">{{ lang.name }}</a>
                  </li>
                  <li class="menu-title">自定义语言</li>
                  <li>
                    <div class="form-control">
                      <div class="join">
                        <input 
                          v-model="customLanguage"
                          type="text" 
                          placeholder="输入语言名称" 
                          class="input input-bordered input-sm join-item flex-1"
                          @keyup.enter="setCustomLanguage"
                        />
                        <button 
                          @click="setCustomLanguage"
                          :disabled="!customLanguage.trim()"
                          class="btn btn-primary btn-sm join-item"
                        >
                          添加
                        </button>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
            <div class="relative">
              <textarea 
                v-model="translatedText"
                class="textarea textarea-bordered w-full h-48 resize-none"
                placeholder="翻译结果将显示在这里..."
                readonly
              ></textarea>
              <div v-if="isTranslating" class="absolute inset-0 flex items-center justify-center bg-base-100 bg-opacity-75">
                <span class="loading loading-spinner loading-md"></span>
              </div>
            </div>
            <div class="flex justify-between items-center mt-2">
              <div class="text-sm text-gray-500">
                {{ translatedText.length }} 字符
              </div>
              <button 
                v-if="translatedText"
                @click="copyToClipboard"
                class="btn btn-sm btn-ghost"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                </svg>
                复制
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- 翻译按钮 -->
    <div class="text-center mt-6">
      <button 
        @click="translateText"
        :disabled="!sourceText.trim() || isTranslating"
        class="btn btn-primary btn-lg"
      >
        <span v-if="isTranslating" class="loading loading-spinner loading-sm"></span>
        {{ isTranslating ? '翻译中...' : '翻译' }}
      </button>
    </div>

      <!-- 历史记录侧边栏 -->
    <div class="fixed top-0 left-0 h-full z-50 transition-all duration-300 ease-in-out"
         :class="historyExpanded ? 'translate-x-0' : '-translate-x-full'">
      <div class="bg-base-100 w-80 h-full flex flex-col shadow-lg">
        <div class="p-4 border-b border-base-300">
          <h2 class="text-xl font-bold">翻译历史记录 ({{ translationHistory.length }})</h2>
        </div>
        <div v-if="translationHistory.length === 0" class="flex-1 flex items-center justify-center text-gray-500">
          暂无翻译记录
        </div>
        <div v-else class="flex-1 overflow-y-auto p-4">
          <div class="space-y-4">
            <div 
              v-for="(record, index) in translationHistory" 
              :key="record.id"
              class="card bg-base-100 shadow-sm hover:shadow-md transition-shadow cursor-pointer h-32 flex flex-col"
            >
              <div class="card-body p-4 flex-1 overflow-hidden">
                <div class="flex justify-between items-start h-full">
                  <div class="flex-1 min-w-0" @click="fillFromHistory(record)">
                    <div class="text-sm text-gray-500 mb-1 truncate">
                      {{ record.timestamp }} | {{ record.targetLanguage }}
                    </div>
                    <div class="text-sm truncate mb-1">
                      <span class="font-medium">源文本：</span>{{ record.sourceText }}
                    </div>
                    <div class="text-sm truncate">
                      <span class="font-medium">翻译：</span>{{ record.translatedText }}
                    </div>
                  </div>
                  <button 
                    @click.stop="deleteHistoryRecord(index)"
                    class="btn btn-ghost btn-sm btn-circle ml-2 flex-shrink-0"
                  >
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="p-4 border-t border-base-300">
          <button @click="historyExpanded = false" class="btn btn-primary w-full">关闭</button>
        </div>
      </div>
    </div>
    <!-- 侧边栏遮罩 -->
    <div v-if="historyExpanded" 
         class="fixed inset-0 bg-black bg-opacity-50 z-40"
         @click="historyExpanded = false">
    </div>
    </div>


  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from 'vue'

// 从localStorage加载数据
const loadFromStorage = (key, defaultValue) => {
  try {
    const stored = localStorage.getItem(key)
    return stored ? JSON.parse(stored) : defaultValue
  } catch (error) {
    console.error(`加载${key}失败:`, error)
    return defaultValue
  }
}

// 保存到localStorage
const saveToStorage = (key, value) => {
  try {
    localStorage.setItem(key, JSON.stringify(value))
  } catch (error) {
    console.error(`保存${key}失败:`, error)
  }
}

// 响应式数据
const sourceText = ref('')
const translatedText = ref('')
const isTranslating = ref(false)
const customLanguage = ref('')
const historyExpanded = ref(false)
const translationHistory = ref(loadFromStorage('translationHistory', []))
const customLanguages = ref(loadFromStorage('customLanguages', []))

// 预设语言列表
const presetLanguages = [
  { code: 'zh', name: '中文' },
  { code: 'en', name: '英语' },
  { code: 'ja', name: '日语' },
  { code: 'ko', name: '韩语' },
  { code: 'fr', name: '法语' },
  { code: 'de', name: '德语' },
  { code: 'es', name: '西班牙语' },
  { code: 'ru', name: '俄语' },
  { code: 'ar', name: '阿拉伯语' },
  { code: 'pt', name: '葡萄牙语' }
]

// 合并预设语言和自定义语言
const languages = reactive([...presetLanguages, ...customLanguages.value])

// 当前选中的语言
const selectedLanguage = ref(loadFromStorage('selectedLanguage', languages[1]))



// 选择语言
const selectLanguage = (language) => {
  selectedLanguage.value = language
}

// 设置自定义语言
const setCustomLanguage = () => {
  if (customLanguage.value.trim()) {
    const newLanguage = {
      code: `custom_${Date.now()}`,
      name: customLanguage.value.trim()
    }
    
    // 检查是否已存在相同名称的自定义语言
    const exists = customLanguages.value.some(lang => lang.name === newLanguage.name)
    if (!exists) {
      customLanguages.value.push(newLanguage)
      languages.push(newLanguage)
      saveToStorage('customLanguages', customLanguages.value)
    }
    
    selectedLanguage.value = newLanguage
    customLanguage.value = ''
  }
}

// 输入处理
const handleInput = () => {
  // 移除自动翻译功能，只清空翻译结果
  if (!sourceText.value.trim()) {
    translatedText.value = ''
  }
}

// 翻译函数
const translateText = async () => {
  if (!sourceText.value.trim() || isTranslating.value) return
  
  isTranslating.value = true
  
  try {
    // 构建翻译提示词
    const systemPrompt = `你是一个专业的翻译助手。请将用户输入的文本翻译成${selectedLanguage.value.name}。要求：
1. 保持原文的语气和风格
2. 确保翻译准确、自然、流畅
3. 如果是专业术语，请提供准确的对应翻译
4. 只返回翻译结果，不要添加任何解释或说明
5. 如果原文已经是目标语言，请直接返回原文`
    
    // 调用API
    const apiUrl = `https://api.jkyai.top/API/depsek3.1.php?question=${encodeURIComponent(sourceText.value)}&type=text&system=${encodeURIComponent(systemPrompt)}`
    
    const response = await fetch(apiUrl)
    const result = await response.text()
    
    translatedText.value = result || '翻译失败，请重试'
    
    // 添加到历史记录
    if (result && result !== '翻译失败，请重试') {
      addToHistory(sourceText.value, result, selectedLanguage.value.name)
    }
  } catch (error) {
    console.error('翻译错误:', error)
    translatedText.value = '翻译服务暂时不可用，请稍后重试'
  } finally {
    isTranslating.value = false
  }
}

// 复制到剪贴板
const copyToClipboard = async () => {
  try {
    await navigator.clipboard.writeText(translatedText.value)
    // 这里可以添加一个toast提示
    alert('已复制到剪贴板')
  } catch (error) {
    console.error('复制失败:', error)
    // 降级方案
    const textArea = document.createElement('textarea')
    textArea.value = translatedText.value
    document.body.appendChild(textArea)
    textArea.select()
    document.execCommand('copy')
    document.body.removeChild(textArea)
    alert('已复制到剪贴板')
  }
}

// 复制文本（通用函数）
const copyText = async (text) => {
  try {
    await navigator.clipboard.writeText(text)
    alert('已复制到剪贴板')
  } catch (error) {
    console.error('复制失败:', error)
    const textArea = document.createElement('textarea')
    textArea.value = text
    document.body.appendChild(textArea)
    textArea.select()
    document.execCommand('copy')
    document.body.removeChild(textArea)
    alert('已复制到剪贴板')
  }
}

// 添加到历史记录
const addToHistory = (source, translated, targetLang) => {
  const record = {
    id: Date.now(),
    sourceText: source,
    translatedText: translated,
    targetLanguage: targetLang,
    timestamp: new Date().toLocaleString('zh-CN')
  }
  translationHistory.value.unshift(record)
  // 限制历史记录数量
  if (translationHistory.value.length > 50) {
    translationHistory.value = translationHistory.value.slice(0, 50)
  }
  saveToStorage('translationHistory', translationHistory.value)
}

// 删除历史记录
const deleteHistoryRecord = (index) => {
  translationHistory.value.splice(index, 1)
  saveToStorage('translationHistory', translationHistory.value)
}

// 从历史记录填充
const fillFromHistory = (record) => {
  sourceText.value = record.sourceText
  // 查找并设置目标语言
  const lang = languages.find(l => l.name === record.targetLanguage)
  if (lang) {
    selectedLanguage.value = lang
  }
  // 不自动触发翻译，只填充内容
  translatedText.value = record.translatedText
  // 关闭侧边栏
  historyExpanded.value = false
}

// 组件挂载时的初始化
onMounted(() => {
  // 确保选中的语言在当前语言列表中存在
  const storedLang = loadFromStorage('selectedLanguage', null)
  if (storedLang) {
    const langExists = languages.find(lang => lang.code === storedLang.code)
    if (langExists) {
      selectedLanguage.value = langExists
    } else {
      selectedLanguage.value = languages[1] // 默认选择英语
    }
  }
})

// 监听选中语言变化并保存
watch(selectedLanguage, (newLang) => {
  saveToStorage('selectedLanguage', newLang)
}, { deep: true })
</script>
