<template>
  <div class="min-h-screen p-6 backdrop-filter backdrop-blur-lg bg-opacity-30 bg-base-100 relative">
    <div :class="historyExpanded ? 'md:ml-80' : ''" class="transition-all duration-300 ease-in-out">
    <!-- 标题 -->
    <div class="flex items-center justify-between mb-8">
      <div class="flex items-center">
      <button 
        @click="historyExpanded = !historyExpanded"
        class="btn btn-ghost btn-circle mr-4"
        aria-label="切换侧边栏"
      >
        <svg v-if="historyExpanded" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
        </svg>
        <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
        </svg>
      </button>
      <h1 class="text-5xl font-aladin font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
        GlesTranslate
      </h1>
      </div>
      <!-- 右侧图标区域 -->
      <div class="flex items-center gap-3">
        <!-- Android 图标 + 横幅 -->
        <div class="relative">
          <a 
            href="https://github.com/Glassous/GlesTranslateAndroid" 
            target="_blank" 
            rel="noopener" 
            class="btn btn-ghost btn-circle group"
            aria-label="打开 Android 端仓库"
            @mouseenter="showAndroidBanner = true"
            @mouseleave="showAndroidBanner = false"
          >
            <!-- Android 品牌图标（Bootstrap Icons: bi-android） -->
            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-[#3DDC84]" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
              <path d="M2.76 3.061a.5.5 0 0 1 .679.2l1.283 2.352A8.9 8.9 0 0 1 8 5a8.9 8.9 0 0 1 3.278.613l1.283-2.352a.5.5 0 1 1 .878.478l-1.252 2.295C14.475 7.266 16 9.477 16 12H0c0-2.523 1.525-4.734 3.813-5.966L2.56 3.74a.5.5 0 0 1 .2-.678ZM5 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2m6 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
            </svg>
          </a>
          <!-- Android 横幅 -->
          <div class="absolute right-full top-1/2 -translate-y-1/2 mr-2 transition-all duration-300 ease-in-out">
            <div 
              :class="[showAndroidBanner ? 'opacity-100 scale-100 px-3 py-1' : 'opacity-0 scale-95 px-0 py-0 pointer-events-none']" 
              class="badge badge-success whitespace-nowrap"
            >
              Android
            </div>
          </div>
        </div>
        <!-- GitHub 图标按钮 -->
        <a 
          href="https://github.com/Glassous/GlesTranslate" 
          target="_blank" 
          rel="noopener" 
          class="btn btn-ghost btn-circle"
          aria-label="打开 GitHub 仓库"
        >
          <svg class="w-6 h-6" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
            <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 
            0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 
            1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 
            0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 
            1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 
            0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"/>
          </svg>
        </a>
      </div>
    </div>
    
    <!-- 数据备份恢复弹窗 -->
    <div :class="['modal', showBackupModal ? 'modal-open' : '']">
      <div class="modal-box">
        <h3 class="font-bold text-lg mb-4">数据备份与恢复</h3>
        <div class="space-y-4">
          <!-- 导出数据 -->
          <div class="card bg-base-200">
            <div class="card-body">
              <h4 class="card-title text-base">导出数据</h4>
              <p class="text-sm text-base-content/70">将所有数据导出为JSON文件</p>
              <div class="card-actions justify-end">
                <button @click="exportData" class="btn btn-primary btn-sm">
                  <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                  </svg>
                  导出
                </button>
              </div>
            </div>
          </div>
          
          <!-- 导入数据 -->
          <div class="card bg-base-200">
            <div class="card-body">
              <h4 class="card-title text-base">导入数据</h4>
              <p class="text-sm text-base-content/70">从JSON文件恢复数据</p>
              <div class="form-control">
                <input 
                  ref="backupFileInput"
                  type="file" 
                  accept=".json"
                  @change="handleBackupFileUpload"
                  class="file-input file-input-bordered file-input-sm w-full"
                />
              </div>
              <div class="card-actions justify-end">
                <button @click="selectBackupFile" class="btn btn-secondary btn-sm">
                  <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M9 19l3 3m0 0l3-3m-3 3V10"></path>
                  </svg>
                  选择文件
                </button>
              </div>
            </div>
          </div>
        </div>
        
        <div class="modal-action">
          <button class="btn btn-ghost" @click="closeBackupModal">关闭</button>
        </div>
      </div>
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
              class="textarea textarea-bordered w-full h-48 resize-none bg-base-200 text-base-content placeholder:text-base-content/50"
              placeholder="请输入要翻译的文本..."
              @input="handleInput"
            ></textarea>
            <div class="flex justify-between items-center mt-2">
              <div class="text-sm text-base-content/60">
                {{ sourceText.length }} / 5000 字符
              </div>
              <!-- 识别按钮组 -->
              <div class="flex items-center gap-2">
                <!-- 音频识别按钮 -->
                <button 
                  @click="openAudioUpload"
                  class="btn btn-sm btn-secondary"
                  title="音频识别"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11a7 7 0 01-7 7m0 0a7 7 0 01-7-7m7 7v4m0 0H8m4 0h4m-4-8a3 3 0 01-3-3V5a3 3 0 116 0v6a3 3 0 01-3 3z"></path>
                  </svg>
                </button>
                <!-- OCR按钮 -->
                <button 
                  @click="openOCRUpload"
                  class="btn btn-sm btn-primary"
                  title="OCR文字识别"
                >
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                  </svg>
                </button>
              </div>
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
                class="textarea textarea-bordered w-full h-48 resize-none bg-base-200 text-base-content placeholder:text-base-content/50"
                placeholder="翻译结果将显示在这里..."
                readonly
              ></textarea>
            </div>
            <div class="flex justify-between items-center mt-2">
              <div class="text-sm text-base-content/60">
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
    <div class="text-center mt-6 flex justify-center space-x-4">
      <button 
        @click="clearTexts"
        class="btn btn-secondary btn-lg"
      >
        清空
      </button>
      <button 
        @click="translateText"
        :disabled="!sourceText.trim() || isTranslating"
        class="btn btn-primary btn-lg"
      >
        <span v-if="isTranslating" class="loading loading-spinner loading-sm"></span>
        {{ isTranslating ? '翻译中...' : '翻译' }}
      </button>
    </div>

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
        <div class="p-4 border-t border-base-300 space-y-2">
          <button @click="openAIConfigModal" class="btn btn-outline w-full">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-2.21 0-4 1.79-4 4s1.79 4 4 4m0-10V2m0 20v-4M4.93 4.93l2.83 2.83M16.24 16.24l2.83 2.83M2 12h4m12 0h4M4.93 19.07l2.83-2.83M16.24 7.76l2.83-2.83"></path>
            </svg>
            AI配置
          </button>
          <button @click="openBackupModal" class="btn btn-outline w-full">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12"></path>
            </svg>
            数据备份
          </button>
        </div>
      </div>
    </div>
    <!-- 侧边栏遮罩 -->
    <div v-if="historyExpanded" 
         class="fixed inset-0 bg-black bg-opacity-50 z-40 md:hidden"
         @click="historyExpanded = false">
    </div>
    </div>


    <!-- 上传弹窗 -->
    <div v-if="showOCRUploadModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center">
      <div class="bg-base-100 rounded-lg p-6 max-w-lg w-full mx-4">
        <div class="flex justify-between items-center mb-4">
          <h3 class="text-xl font-bold">{{ uploadType === 'audio' ? '音频识别' : 'OCR文字识别' }}</h3>
          <button @click="closeOCRUploadModal" class="btn btn-ghost btn-sm btn-circle">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </button>
        </div>
        
        <!-- 拖拽上传区域 -->
        <div 
          @drop="handleDrop"
          @dragover.prevent="isDragOver = true"
          @dragleave="isDragOver = false"
          @dragenter.prevent
                   :class="['border-2 border-dashed rounded-lg p-8 text-center transition-colors', 
                   isDragOver ? 'border-primary bg-primary/10' : 'border-base-300']"
        >
          <svg v-if="uploadType === 'image'" class="w-12 h-12 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path>
          </svg>
          <svg v-else class="w-12 h-12 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19V6l12-3v13M9 19c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zm12-3c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zM9 10l12-3"></path>
          </svg>
          <p class="text-lg font-medium mb-2">拖拽{{ uploadType === 'audio' ? '音频文件' : '图片' }}到此处</p>
          <p class="text-sm text-base-content/60 mb-4">或选择以下方式上传{{ uploadType === 'audio' ? '音频' : '图片' }}</p>
        </div>
        
        <!-- 操作按钮 -->
         <div class="grid grid-cols-2 gap-3 mt-4">
           <!-- 粘贴图片/音频 -->
           <button v-if="uploadType === 'image'" @click="pasteImage" class="btn btn-outline flex flex-col items-center p-4 h-auto">
             <svg class="w-6 h-6 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
             </svg>
             <span class="text-xs">粘贴图片</span>
           </button>
           
           <!-- 选择文件 -->
           <button @click="selectFile" :class="uploadType === 'audio' ? 'col-span-2' : ''" class="btn btn-outline flex flex-col items-center p-4 h-auto">
             <svg class="w-6 h-6 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-5L12 5H5a2 2 0 00-2 2z"></path>
             </svg>
             <span class="text-xs">选择文件</span>
           </button>
         </div>
        
        <!-- 隐藏的文件输入 -->
         <input 
           ref="fileInput"
           type="file"
           :accept="uploadType === 'audio' ? 'audio/*' : 'image/*'"
           @change="handleFileUpload"
           class="hidden"
         />
      </div>
    </div>

    <!-- 识别结果弹窗 -->
    <div v-if="showOCRModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center">
      <div class="bg-base-100 rounded-lg p-6 max-w-2xl w-full mx-4 max-h-[80vh] overflow-y-auto">
        <div class="flex justify-between items-center mb-4">
          <h3 class="text-xl font-bold">{{ uploadType === 'audio' ? '音频识别结果' : 'OCR识别结果' }}</h3>
          <button @click="closeOCRModal" class="btn btn-ghost btn-sm btn-circle">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </button>
        </div>
        
        <div v-if="shouldShowLoadingAnimation" class="flex items-center justify-center py-8">
          <span class="loading loading-spinner loading-lg"></span>
          <span class="ml-2">{{ uploadType === 'audio' ? '正在识别音频中的文字...' : '正在识别图片中的文字...' }}</span>
        </div>
        
        <div v-else-if="ocrResult || audioResult" class="space-y-4">
          <div class="form-control">
            <label class="label">
              <span class="label-text">识别到的文字内容：</span>
            </label>
            <textarea 
              :value="uploadType === 'audio' ? audioResult : ocrResult"
              class="textarea textarea-bordered w-full h-48 resize-none bg-base-200 text-base-content placeholder:text-base-content/50"
              readonly
            ></textarea>
          </div>
          
          <div class="flex justify-end space-x-2">
            <button @click="closeOCRModal" class="btn btn-secondary">取消</button>
            <button @click="confirmOCRResult" class="btn btn-primary">确认并填入</button>
          </div>
        </div>
        
        <div v-else-if="ocrError || audioError" class="text-center py-8">
          <div class="text-error mb-4">{{ uploadType === 'audio' ? audioError : ocrError }}</div>
          <button @click="closeOCRModal" class="btn btn-secondary">关闭</button>
        </div>
      </div>
    </div>

    <!-- AI配置模态框（daisyUI） -->
    <div :class="['modal', showAIConfigModal ? 'modal-open' : '']">
      <div class="modal-box max-w-xl">
        <h3 class="font-bold text-lg">AI 配置</h3>
        <div class="form-control mt-4">
          <label class="label cursor-pointer">
            <span class="label-text">启用自定义AI模型配置</span>
            <input type="checkbox" v-model="aiConfigEnabledDraft" class="toggle toggle-primary" />
          </label>
        </div>

        <div v-if="aiConfigEnabledDraft" class="space-y-3 mt-4">
          <div class="form-control">
            <label class="label"><span class="label-text">Base URL</span></label>
            <input type="url" v-model.trim="aiConfigDraft.baseUrl" placeholder="https://api.example.com/v1" class="input input-bordered" />
          </div>
          <div class="form-control">
            <label class="label"><span class="label-text">Model</span></label>
            <input type="text" v-model.trim="aiConfigDraft.model" placeholder="模型名称" class="input input-bordered" />
          </div>
          <div class="form-control">
            <label class="label"><span class="label-text">API Key</span></label>
            <div class="relative">
              <input 
                :type="showApiKey ? 'text' : 'password'" 
                v-model.trim="aiConfigDraft.apiKey" 
                placeholder="密钥" 
                class="input input-bordered pr-10" 
              />
              <button 
                type="button"
                @click="showApiKey = !showApiKey"
                class="absolute right-2 top-1/2 transform -translate-y-1/2 btn btn-ghost btn-sm btn-square"
              >
                <svg v-if="showApiKey" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"></path>
                </svg>
                <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                </svg>
              </button>
            </div>
          </div>
          
          <!-- 全模态模型配置 -->
          <div class="divider">全模态模型配置</div>
          <div class="form-control">
            <label class="label cursor-pointer">
              <span class="label-text">启用全模态模型（用于音频和图像识别）</span>
              <input type="checkbox" v-model="multiModalEnabledDraft" class="toggle toggle-secondary" />
            </label>
          </div>
          <div v-if="multiModalEnabledDraft" class="form-control">
            <label class="label"><span class="label-text">全模态模型名称</span></label>
            <input type="text" v-model.trim="aiConfigDraft.multiModalModel" placeholder="如：gpt-4-vision-preview" class="input input-bordered" />
          </div>
        </div>

        <div class="modal-action">
          <button class="btn btn-secondary" @click="closeAIConfigModal">取消</button>
          <button class="btn btn-primary" @click="saveAIConfig">保存</button>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch, computed } from 'vue'

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
const showAndroidBanner = ref(false)

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

// 翻译函数 - 支持AI配置和流式输出
const translateText = async () => {
  if (!sourceText.value.trim() || isTranslating.value) return
  
  isTranslating.value = true
  translatedText.value = '' // 清空之前的结果
  
  try {
    // 构建翻译提示词
    const systemPrompt = `你是一个专业的翻译助手。请将用户输入的文本翻译成${selectedLanguage.value.name}。要求：
1. 保持原文的语气和风格
2. 确保翻译准确、自然、流畅
3. 如果是专业术语，请提供准确的对应翻译
4. 只返回翻译结果，不要添加任何解释或说明
5. 如果原文已经是目标语言，请直接返回原文`
    
    // 检查是否启用自定义AI配置
    if (aiConfigEnabled.value && aiConfig.baseUrl && aiConfig.model && aiConfig.apiKey) {
      // 使用自定义AI配置进行翻译
      await translateWithCustomAI(systemPrompt)
    } else {
      // 使用默认API进行翻译
      await translateWithDefaultAPI(systemPrompt)
    }
  } catch (error) {
    console.error('翻译错误:', error)
    translatedText.value = '翻译服务暂时不可用，请稍后重试'
  } finally {
    isTranslating.value = false
  }
}

// 使用自定义AI配置进行翻译（支持流式输出）
const translateWithCustomAI = async (systemPrompt) => {
  try {
    const requestBody = {
      model: aiConfig.model,
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: sourceText.value }
      ],
      stream: true
    }
    
    const response = await fetch(aiConfig.baseUrl + '/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${aiConfig.apiKey}`
      },
      body: JSON.stringify(requestBody)
    })
    
    if (!response.ok) {
      throw new Error(`API请求失败: ${response.status} ${response.statusText}`)
    }
    
    const reader = response.body.getReader()
    const decoder = new TextDecoder()
    let buffer = ''
    
    while (true) {
      const { done, value } = await reader.read()
      if (done) break
      
      buffer += decoder.decode(value, { stream: true })
      const lines = buffer.split('\n')
      buffer = lines.pop() || '' // 保留不完整的行
      
      for (const line of lines) {
        if (line.trim() === '') continue
        if (line.startsWith('data: ')) {
          const data = line.slice(6)
          if (data === '[DONE]') continue
          
          try {
            const parsed = JSON.parse(data)
            const content = parsed.choices?.[0]?.delta?.content
            if (content) {
              translatedText.value += content
            }
          } catch (e) {
            console.warn('解析流式数据失败:', e)
          }
        }
      }
    }
    
    // 添加到历史记录
    if (translatedText.value && translatedText.value !== '翻译失败，请重试') {
      addToHistory(sourceText.value, translatedText.value, selectedLanguage.value.name)
    }
  } catch (error) {
    console.error('自定义AI翻译失败:', error)
    throw error
  }
}

// 使用默认API进行翻译
const translateWithDefaultAPI = async (systemPrompt) => {
  try {
    const apiUrl = `https://api.jkyai.top/API/depsek3.1.php?question=${encodeURIComponent(sourceText.value)}&type=text&system=${encodeURIComponent(systemPrompt)}`
    
    const response = await fetch(apiUrl)
    const result = await response.text()
    
    translatedText.value = result || '翻译失败，请重试'
    
    // 添加到历史记录
    if (result && result !== '翻译失败，请重试') {
      addToHistory(sourceText.value, result, selectedLanguage.value.name)
    }
  } catch (error) {
    console.error('默认API翻译失败:', error)
    throw error
  }
}

// 清空文本框
const clearTexts = () => {
  sourceText.value = ''
  translatedText.value = ''
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

  // 进入页面时展示“Android”横幅，2秒后收缩
  showAndroidBanner.value = true
  setTimeout(() => {
    showAndroidBanner.value = false
  }, 2000)
})

// 监听选中语言变化并保存
watch(selectedLanguage, (newLang) => {
  saveToStorage('selectedLanguage', newLang)
}, { deep: true })

// AI配置相关
const showAIConfigModal = ref(false)
const aiConfigEnabled = ref(loadFromStorage('aiConfigEnabled', false))
const aiConfig = reactive(loadFromStorage('aiConfig', { baseUrl: '', model: '', apiKey: '', multiModalModel: '' }))
const aiConfigEnabledDraft = ref(false)
const aiConfigDraft = reactive({ baseUrl: '', model: '', apiKey: '', multiModalModel: '' })
const multiModalEnabled = ref(loadFromStorage('multiModalEnabled', false))
const multiModalEnabledDraft = ref(false)
const showApiKey = ref(false)

// 计算属性：是否显示加载动画
const shouldShowLoadingAnimation = computed(() => {
  const isProcessing = isOCRProcessing.value || isAudioProcessing.value
  if (!isProcessing) return false
  
  // 如果启用了全模态模型，不显示加载动画（支持流式输出）
  if (multiModalEnabled.value && aiConfig.baseUrl && aiConfig.apiKey && aiConfig.multiModalModel) {
    return false
  }
  
  // 否则显示加载动画
  return true
})

const openAIConfigModal = () => {
  aiConfigEnabledDraft.value = !!aiConfigEnabled.value
  aiConfigDraft.baseUrl = aiConfig.baseUrl || ''
  aiConfigDraft.model = aiConfig.model || ''
  aiConfigDraft.apiKey = aiConfig.apiKey || ''
  aiConfigDraft.multiModalModel = aiConfig.multiModalModel || ''
  multiModalEnabledDraft.value = !!multiModalEnabled.value
  showAIConfigModal.value = true
}

// 数据备份恢复相关
const showBackupModal = ref(false)
const backupFileInput = ref(null)

const openBackupModal = () => {
  showBackupModal.value = true
}

const closeBackupModal = () => {
  showBackupModal.value = false
}

const exportData = () => {
  try {
    // 收集所有需要备份的数据
    const backupData = {
      version: '1.0',
      timestamp: new Date().toISOString(),
      data: {
        translationHistory: translationHistory.value,
        customLanguages: customLanguages.value,
        selectedLanguage: selectedLanguage.value,
        aiConfigEnabled: aiConfigEnabled.value,
        aiConfig: aiConfig,
        multiModalEnabled: multiModalEnabled.value
      }
    }
    
    // 创建并下载JSON文件
    const dataStr = JSON.stringify(backupData, null, 2)
    const dataBlob = new Blob([dataStr], { type: 'application/json' })
    const url = URL.createObjectURL(dataBlob)
    
    const link = document.createElement('a')
    link.href = url
    link.download = `glestranslate-backup-${new Date().toISOString().split('T')[0]}.json`
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
    URL.revokeObjectURL(url)
    
    alert('数据导出成功！')
  } catch (error) {
    console.error('导出数据失败:', error)
    alert('导出数据失败，请重试')
  }
}

const selectBackupFile = () => {
  backupFileInput.value?.click()
}

const handleBackupFileUpload = async (event) => {
  const file = event.target.files[0]
  if (!file) return
  
  try {
    const text = await file.text()
    const backupData = JSON.parse(text)
    
    // 验证数据格式
    if (!backupData.data) {
      throw new Error('无效的备份文件格式')
    }
    
    // 恢复数据
    if (backupData.data.translationHistory) {
      translationHistory.value = backupData.data.translationHistory
      saveToStorage('translationHistory', translationHistory.value)
    }
    
    if (backupData.data.customLanguages) {
      customLanguages.value = backupData.data.customLanguages
      saveToStorage('customLanguages', customLanguages.value)
      // 重新构建语言列表
      languages.splice(presetLanguages.length)
      languages.push(...customLanguages.value)
    }
    
    if (backupData.data.selectedLanguage) {
      selectedLanguage.value = backupData.data.selectedLanguage
      saveToStorage('selectedLanguage', selectedLanguage.value)
    }
    
    if (backupData.data.aiConfigEnabled !== undefined) {
      aiConfigEnabled.value = backupData.data.aiConfigEnabled
      saveToStorage('aiConfigEnabled', aiConfigEnabled.value)
    }
    
    if (backupData.data.aiConfig) {
      Object.assign(aiConfig, backupData.data.aiConfig)
      saveToStorage('aiConfig', aiConfig)
    }
    
    if (backupData.data.multiModalEnabled !== undefined) {
      multiModalEnabled.value = backupData.data.multiModalEnabled
      saveToStorage('multiModalEnabled', multiModalEnabled.value)
    }
    
    alert('数据恢复成功！')
    closeBackupModal()
  } catch (error) {
    console.error('导入数据失败:', error)
    alert('导入数据失败，请检查文件格式')
  }
  
  // 清空文件输入
  event.target.value = ''
}

const closeAIConfigModal = () => {
  showAIConfigModal.value = false
}

const saveAIConfig = () => {
  if (aiConfigEnabledDraft.value) {
    aiConfig.baseUrl = aiConfigDraft.baseUrl
    aiConfig.model = aiConfigDraft.model
    aiConfig.apiKey = aiConfigDraft.apiKey
    aiConfig.multiModalModel = aiConfigDraft.multiModalModel
    aiConfigEnabled.value = true
  } else {
    aiConfigEnabled.value = false
  }
  
  multiModalEnabled.value = multiModalEnabledDraft.value
  
  saveToStorage('aiConfigEnabled', aiConfigEnabled.value)
  saveToStorage('aiConfig', aiConfig)
  saveToStorage('multiModalEnabled', multiModalEnabled.value)
  showAIConfigModal.value = false
}

// OCR相关响应式数据
const fileInput = ref(null)
const showOCRModal = ref(false)
const showOCRUploadModal = ref(false)
const isOCRProcessing = ref(false)
const ocrResult = ref('')
const ocrError = ref('')
const isDragOver = ref(false)

// 音频识别相关
const isAudioProcessing = ref(false)
const audioResult = ref('')
const audioError = ref('')
const uploadType = ref('') // 'image' 或 'audio'

// OCR相关方法
const openOCRUpload = () => {
  uploadType.value = 'image'
  showOCRUploadModal.value = true
}

// 音频识别相关方法
const openAudioUpload = () => {
  uploadType.value = 'audio'
  showOCRUploadModal.value = true
}

const closeOCRUploadModal = () => {
  showOCRUploadModal.value = false
  isDragOver.value = false
}

// 处理拖拽上传
const handleDrop = (event) => {
  event.preventDefault()
  isDragOver.value = false
  
  const files = event.dataTransfer.files
  if (files.length > 0) {
    const file = files[0]
    processFile(file)
  }
}

// 粘贴图片
const pasteImage = async () => {
  try {
    const clipboardItems = await navigator.clipboard.read()
    for (const clipboardItem of clipboardItems) {
      for (const type of clipboardItem.types) {
        if (type.startsWith('image/')) {
          const blob = await clipboardItem.getType(type)
          const file = new File([blob], 'pasted-image.png', { type })
          processImageFile(file)
          return
        }
      }
    }
    alert('剪贴板中没有找到图片')
  } catch (error) {
    console.error('粘贴图片失败:', error)
    alert('粘贴图片失败，请确保剪贴板中有图片内容')
  }
}

// 选择文件
const selectFile = () => {
  fileInput.value?.click()
}

// 处理文件
const processFile = (file) => {
  if (uploadType.value === 'audio') {
    processAudioFile(file)
  } else {
    processImageFile(file)
  }
}

// 处理图片文件
const processImageFile = (file) => {
  // 检查文件类型
  if (!file.type.startsWith('image/')) {
    alert('请选择图片文件')
    return
  }
  
  // 检查文件大小 (限制为10MB)
  if (file.size > 10 * 1024 * 1024) {
    alert('图片文件大小不能超过10MB')
    return
  }
  
  // 关闭上传弹窗，显示结果弹窗
  closeOCRUploadModal()
  showOCRModal.value = true
  isOCRProcessing.value = true
  ocrResult.value = ''
  ocrError.value = ''
  
  // 调用OCR API
  callOCRAPI(file)
}

// 处理音频文件
const processAudioFile = (file) => {
  // 检查文件类型
  if (!file.type.startsWith('audio/')) {
    alert('请选择音频文件')
    return
  }
  
  // 检查文件大小 (限制为50MB)
  if (file.size > 50 * 1024 * 1024) {
    alert('音频文件大小不能超过50MB')
    return
  }
  
  // 关闭上传弹窗，显示结果弹窗
  closeOCRUploadModal()
  showOCRModal.value = true
  isAudioProcessing.value = true
  audioResult.value = ''
  audioError.value = ''
  
  // 调用音频识别API
  callAudioAPI(file)
}

// 调用音频识别API
const callAudioAPI = async (file) => {
  try {
    // 检查是否启用全模态模型
    if (multiModalEnabled.value && aiConfig.baseUrl && aiConfig.apiKey && aiConfig.multiModalModel) {
      await callAudioAPIWithCustomAI(file)
    } else {
      await callAudioAPIWithDefault(file)
    }
  } catch (error) {
    console.error('音频识别API调用失败:', error)
    audioError.value = '音频识别服务暂时不可用，请稍后重试'
  } finally {
    isAudioProcessing.value = false
  }
}

// 使用自定义AI进行音频识别
const callAudioAPIWithCustomAI = async (file) => {
  // 将音频文件转换为base64
  const base64Audio = await fileToBase64(file)
  
  const requestBody = {
    model: aiConfig.multiModalModel,
    messages: [
      {
        role: "user",
        content: [
          {
            type: "text",
            text: "请识别这个音频文件中的文字内容，直接返回识别结果，不要添加任何解释。"
          },
          {
            type: "audio",
            audio: {
              data: base64Audio.split(',')[1], // 移除data:audio/...;base64,前缀
              format: file.type.split('/')[1] || 'mp3'
            }
          }
        ]
      }
    ],
    max_tokens: 1000,
    stream: true
  }

  const response = await fetch(`${aiConfig.baseUrl}/chat/completions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${aiConfig.apiKey}`
    },
    body: JSON.stringify(requestBody)
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  const reader = response.body.getReader()
  const decoder = new TextDecoder()
  audioResult.value = ''

  try {
    while (true) {
      const { done, value } = await reader.read()
      if (done) break

      const chunk = decoder.decode(value, { stream: true })
      const lines = chunk.split('\n')

      for (const line of lines) {
        if (line.startsWith('data: ')) {
          const data = line.slice(6).trim()
          if (data === '[DONE]') return

          try {
            const parsed = JSON.parse(data)
            if (parsed.choices && parsed.choices[0] && parsed.choices[0].delta && parsed.choices[0].delta.content) {
              audioResult.value += parsed.choices[0].delta.content
            }
          } catch (e) {
            // 忽略解析错误
          }
        }
      }
    }
  } finally {
    reader.releaseLock()
  }
}

// 使用默认API进行音频识别
const callAudioAPIWithDefault = async (file) => {
  // 创建FormData
  const formData = new FormData()
  formData.append('file', file)
  
  // 调用音频识别API
  const response = await fetch('https://api.pearktrue.cn/api/audiocr/', {
    method: 'POST',
    body: formData
  })
  
  const result = await response.json()
  
  if (result.code === 200 && result.data && result.data.content) {
    audioResult.value = result.data.content
  } else {
    audioError.value = result.msg || '音频识别失败，请重试'
  }
}

// 文件转base64工具函数
const fileToBase64 = (file) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    reader.readAsDataURL(file)
    reader.onload = () => resolve(reader.result)
    reader.onerror = error => reject(error)
  })
}

// 调用OCR API
const callOCRAPI = async (file) => {
  try {
    // 检查是否启用全模态模型
    if (multiModalEnabled.value && aiConfig.baseUrl && aiConfig.apiKey && aiConfig.multiModalModel) {
      await callOCRAPIWithCustomAI(file)
    } else {
      await callOCRAPIWithDefault(file)
    }
  } catch (error) {
    console.error('OCR API调用失败:', error)
    ocrError.value = 'OCR服务暂时不可用，请稍后重试'
  } finally {
    isOCRProcessing.value = false
  }
}

// 使用自定义AI进行OCR识别
const callOCRAPIWithCustomAI = async (file) => {
  // 将图像文件转换为base64
  const base64Image = await fileToBase64(file)
  
  const requestBody = {
    model: aiConfig.multiModalModel,
    messages: [
      {
        role: "user",
        content: [
          {
            type: "text",
            text: "请识别这张图片中的所有文字内容，直接返回识别结果，不要添加任何解释。"
          },
          {
            type: "image_url",
            image_url: {
              url: base64Image
            }
          }
        ]
      }
    ],
    max_tokens: 1000,
    stream: true
  }

  const response = await fetch(`${aiConfig.baseUrl}/chat/completions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${aiConfig.apiKey}`
    },
    body: JSON.stringify(requestBody)
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  const reader = response.body.getReader()
  const decoder = new TextDecoder()
  ocrResult.value = ''

  try {
    while (true) {
      const { done, value } = await reader.read()
      if (done) break

      const chunk = decoder.decode(value, { stream: true })
      const lines = chunk.split('\n')

      for (const line of lines) {
        if (line.startsWith('data: ')) {
          const data = line.slice(6).trim()
          if (data === '[DONE]') return

          try {
            const parsed = JSON.parse(data)
            if (parsed.choices && parsed.choices[0] && parsed.choices[0].delta && parsed.choices[0].delta.content) {
              ocrResult.value += parsed.choices[0].delta.content
            }
          } catch (e) {
            // 忽略解析错误
          }
        }
      }
    }
  } finally {
    reader.releaseLock()
  }
}

// 使用默认API进行OCR识别
const callOCRAPIWithDefault = async (file) => {
  // 创建FormData
  const formData = new FormData()
  formData.append('file', file)
  
  // 调用OCR API
  const response = await fetch('https://api.pearktrue.cn/api/ocr/', {
    method: 'POST',
    body: formData
  })
  
  const result = await response.json()
  
  if (result.code === 200 && result.data && result.data.ParsedText) {
    ocrResult.value = result.data.ParsedText
  } else {
    ocrError.value = result.msg || 'OCR识别失败，请重试'
  }
}

const handleFileUpload = async (event) => {
  const file = event.target.files[0]
  if (!file) return
  
  // 处理文件
  processFile(file)
  
  // 清空文件输入
  event.target.value = ''
}

const confirmOCRResult = () => {
  const result = uploadType.value === 'audio' ? audioResult.value : ocrResult.value
  if (result) {
    sourceText.value = result
    closeOCRModal()
  }
}

const closeOCRModal = () => {
  showOCRModal.value = false
  isOCRProcessing.value = false
  isAudioProcessing.value = false
  ocrResult.value = ''
  ocrError.value = ''
  audioResult.value = ''
  audioError.value = ''
}
</script>
