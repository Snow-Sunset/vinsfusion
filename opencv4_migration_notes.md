# VINS-Fusion OpenCV 4 迁移注意事项

## 已自动处理的内容
- 更新了所有CMakeLists.txt中的OpenCV路径
- 替换了常见的标志常量前缀（CV_* 到 cv::*）
- 更新了图像加载和窗口标志
- 更新了颜色转换标志（如cv::COLOR_BGR2GRAY -> cv::COLOR_BGR2GRAY）
- 更新了绘制标志（如CV_AA -> cv::LINE_AA）
- 更新了特征检测参数
- 更新了其他常用OpenCV标志

## 需要手动检查的内容

1. **SFM模块兼容性问题**
   - OpenCV 4中的SFM模块可能与Ceres版本不兼容
   - 如遇到ceres::SubsetManifold相关错误，可考虑禁用SFM模块
   - 添加 `-D BUILD_opencv_sfm=OFF` 到CMake配置选项

2. **其他可能的API变更**
   - 某些函数签名或行为在OpenCV 4中可能已改变
   - 请关注编译错误，根据具体错误信息进行调整

3. **头文件包含**
   - 某些组件可能需要额外包含特定的头文件

4. **特定模块迁移**
   - 一些在OpenCV 3中存在的模块可能在OpenCV 4中被移动或重命名
   - 例如：contrib模块中的一些功能

## 编译建议
1. 使用 `catkin_make_isolated` 而不是 `catkin_make` 来处理非catkin包
2. 如遇到编译错误，先检查具体错误信息，再针对性解决
3. 可以考虑使用ccmake或cmake-gui查看和调整CMake配置

## 常见编译错误及解决方案
- **找不到头文件错误**：检查是否需要添加额外的头文件包含
- **未定义的引用错误**：可能是因为某个模块没有正确链接，检查CMakeLists.txt
- **函数签名不匹配**：需要手动更新函数调用以匹配新的API
