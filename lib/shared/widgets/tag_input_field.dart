import 'package:flutter/material.dart';
import 'package:whatdoidraw/l10n/app_localizations.dart';

/// Widget reutilizable para la entrada de etiquetas (tags) mediante chips.
///
/// El usuario escribe una etiqueta y al pulsar espacio, coma o intro,
/// el texto se convierte en un chip visual. Cada chip puede eliminarse
/// individualmente. Tiene un máximo de [maxTags] etiquetas.
class TagInputField extends StatefulWidget {
  /// Callback que se invoca cada vez que la lista de tags cambia.
  final ValueChanged<List<String>> onTagsChanged;

  /// Número máximo de tags permitidos.
  final int maxTags;

  /// Tags iniciales (para edición).
  final List<String> initialTags;

  const TagInputField({
    super.key,
    required this.onTagsChanged,
    this.maxTags = 5,
    this.initialTags = const [],
  });

  @override
  State<TagInputField> createState() => _TagInputFieldState();
}

class _TagInputFieldState extends State<TagInputField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List<String>.from(widget.initialTags);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Normaliza y añade el tag actual al estado si es válido.
  void _submitCurrentInput() {
    final raw = _controller.text;
    final normalized = _normalize(raw);
    if (normalized.isEmpty) return;
    if (_tags.contains(normalized)) {
      _controller.clear();
      return;
    }
    if (_tags.length >= widget.maxTags) return;

    setState(() {
      _tags.add(normalized);
      _controller.clear();
    });
    widget.onTagsChanged(_tags);
  }

  /// Elimina el tag en la posición [index].
  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
    widget.onTagsChanged(_tags);
  }

  /// Convierte el texto en minúsculas y elimina caracteres no alfanuméricos
  /// (excepto guión medio) para garantizar tags limpios y consistentes.
  String _normalize(String input) {
    return input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\-]'), '')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final atLimit = _tags.length >= widget.maxTags;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fila de chips existentes
        if (_tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: List.generate(_tags.length, (i) {
                return Chip(
                  label: Text(
                    '#${_tags[i]}',
                    style: TextStyle(
                      color: colorScheme.onSecondaryContainer,
                      fontSize: 13,
                    ),
                  ),
                  backgroundColor: colorScheme.secondaryContainer,
                  deleteIconColor: colorScheme.onSecondaryContainer,
                  onDeleted: () => _removeTag(i),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                );
              }),
            ),
          ),

        // Campo de entrada (solo visible si no se ha llegado al límite)
        if (!atLimit)
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: l10n.tagInputHint(widget.maxTags),
              helperText: l10n.tagInputHelper,
              prefixIcon: const Icon(Icons.tag, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              isDense: true,
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              _submitCurrentInput();
              _focusNode.requestFocus();
            },
            onChanged: (value) {
              // Si el último carácter es espacio o coma, confirmar el tag.
              if (value.endsWith(' ') || value.endsWith(',')) {
                _controller.text = value.trimRight().replaceAll(',', '');
                _submitCurrentInput();
              }
            },
          ),

        // Indicador de límite alcanzado
        if (atLimit)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              l10n.tagInputLimitReached(widget.maxTags),
              style: TextStyle(fontSize: 12, color: colorScheme.outline),
            ),
          ),
      ],
    );
  }
}
