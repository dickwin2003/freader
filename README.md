<div align="center">

# 📖 FReader

**跨平台开源阅读器 · 内置 AI 助手 · 离线 OCR · 翻译 · 笔记**

Flutter 构建 · 支持 Android / iOS / 桌面

</div>

---

## ✨ 这是什么

FReader 是一款**以「阅读 + 沉淀」为核心**的跨平台阅读器。不仅能看书，还把
**AI 阅读助手、翻译、拍照取字(OCR)、语音朗读、读书笔记**整合成一套顺手的工作流——
读书时随手速读、翻译、记笔记，旅游时拍照翻译、语音朗读，离线也能用。

> 导航四个 tab：**书架 · 笔记 · AI · 我的**，干净不臃肿。

## 📚 阅读

- **多格式**：TXT / EPUB / PDF / MOBI(AZW/AZW3) / **DOCX** / **HTML** / Markdown
  - DOCX：解压取 `word/document.xml` 正文；HTML：自动去标签成纯文本
- **书架**：本地书 + 在线书源（兼容常见书源 JSON 格式导入）；按格式分色图标（PDF/EPUB/MOBI/TXT/DOCX/HTML…）
- **阅读器**：字号/行距/背景可调并持久化、目录、**书签**（存位置·跳转·删除）、
  **滑到底自动翻章**（连续阅读）、**朗读**
- **进度同步**：WebDAV 全量备份（书源 / 书籍 / 阅读进度 / 笔记 / 书签 / 净化规则）

## 🤖 AI（云 + 端侧，可切换）

- **云端 LLM**：OpenAI 兼容 + **Anthropic 兼容**（DeepSeek / 通义 / LongCat / GPT / 本地 Ollama 都能接）
- **端侧推理**（完全离线）：集成 `flutter_gemma`，支持 Gemma 3n / Qwen 等 LiteRT 模型
  - **断点续传下载**（自定义 dio + HTTP Range，可暂停/继续）
  - 模型源下拉（国内 ModelScope 直连，免 token，~9MB/s）
- **AI 阅读助手**：章节速读、全书梗概、人物梳理、自由问答（多轮记忆）、拍照取字
- **翻译**：文本翻译 + **拍照 OCR 取字** + **语音输入(STT)** + **朗读(TTS)**，旅游利器

## 📝 笔记

- 心得/读后感，可关联书籍；列表搜索（标题/正文/书名）
- **AI 总结**：从书架选书 → AI 读取正文生成摘要 → 自动存为笔记
- **AI 读后感**：把一本书的所有笔记归纳成读后感
- 书名可点击跳转书籍详情

## 🔊 OCR / 语音（专件专用，不靠大模型）

- **OCR**：Google ML Kit 文字识别（中文/日韩/拉丁，离线）
- **朗读**：**Edge TTS**（微软神经语音，免费无 key，质量高）；失败自动回退系统 TTS
- **语音输入**：系统 STT（可装离线语音包）

## 🛠️ 开发者友好

- **应用内日志面板**：捕获错误 + 关键操作面包屑，**原生崩溃后重开仍可看崩溃前日志**
- 手写 Riverpod provider（无 codegen 依赖即可跑）；drift 数据库（schemaVersion 3）

---

## 📸 应用截图

见 [`app截图/`](./app截图) 目录。

<!-- 截图示例（把图片放进 app截图/ 后取消注释）：
<div align="center">
<img src="app截图/书架.jpg" width="270" />
<img src="app截图/阅读器.jpg" width="270" />
<img src="app截图/AI助手.jpg" width="270" />
</div>
-->

---

## 🧱 技术栈

| 层 | 技术 |
|---|---|
| 框架 | Flutter（Material 3） |
| 状态/DI | Riverpod（手写 provider） |
| 数据库 | drift（SQLite）|
| 网络 | dio |
| 路由 | go_router |
| 端侧 AI | flutter_gemma（LiteRT / MediaPipe）|
| OCR | google_mlkit_text_recognition |
| 语音 | speech_to_text · flutter_tts · Edge TTS(WebSocket) · just_audio |
| 本地解析 | epubx · pdfrx · archive · 自研 MOBI/DOCX 解析 |

## 🚀 构建

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # 生成 drift/json 代码
flutter run                                                # 调试
flutter build apk --release                                # 发布包
```

> 最低 Android SDK 24（flutter_gemma / ML Kit 稳定性要求）。

## ⚠️ 已知限制（诚实交代）

- 端侧小模型（Gemma 3n / Qwen，≤2B）文本能力有限——**追求质量建议用云端 LLM**；端侧作离线备用。
- Edge TTS 走的是 Edge 浏览器「大声朗读」的**非官方接口**，协议变动或部分网络拦截可能失效（已做系统 TTS 回退）。
- 旧版 `.doc`（二进制）暂不支持，请转 `.docx` / PDF。
- PDF 无文本提取，AI 助手/朗读对 PDF 不可用。

## 📁 项目结构

```
lib/
├── core/database/        # drift 表 + AppDatabase
├── data/                 # entities / repositories
├── service/              # web_book / local_file_reader / mobi / llm / ocr / tts / dev
├── providers/            # 手写 Riverpod providers
└── ui/pages/             # bookshelf / reader / ai_assistant / ai_translate / notes / ai_hub / settings ...
```

## 📄 License

MIT
