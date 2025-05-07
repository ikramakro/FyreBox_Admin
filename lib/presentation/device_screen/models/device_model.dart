import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import 'actions_item_model.dart';

class DeviceModel {
  List<SelectionPopupModel> dropdownItemList = [
    SelectionPopupModel(
      id: 2,
      title: "All",
    ),
    SelectionPopupModel(
      id: 1,
      title: "Active",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 2,
      title: "In-Active",
    ),
  ];
  List<SelectionPopupModel> deviceTypeDropdownItemList = [
    SelectionPopupModel(
      id: 2,
      title: "Admin",
    ),
    SelectionPopupModel(
      id: 1,
      title: "Agent",
      isSelected: true,
    ),
  ];

  List<SelectionPopupModel> orderdeviceTypeDropdownItemList = [
    SelectionPopupModel(
      id: 2,
      title: "Fyrebox Unit",
    ),
    SelectionPopupModel(
      id: 1,
      title: "Admin Unit",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 1,
      title: "Intefration Unit",
      isSelected: true,
    ),
  ];
  List<ActionsItemModel> actionsItemList =
      List.generate(2, (index) => ActionsItemModel());
}
